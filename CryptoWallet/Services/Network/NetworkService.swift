import Foundation


final class NetworkService {
    static let shared = NetworkService()

    private init() {}

    func fetchCryptocurrencyData(completion: @escaping ([Cryptocurrency]?) -> Void) {
        let symbols = ["BTC", "ETH", "TRX", "LUNA", "DOT", "DOGE", "USDT", "XLM", "ADA", "XRP"]
        let dispatchGroup = DispatchGroup()
        var cryptocurrencies: [Cryptocurrency] = []

        for symbol in symbols {
            dispatchGroup.enter()
            let urlString = "https://data.messari.io/api/v1/assets/\(symbol)/metrics"

            guard let url = URL(string: urlString) else {
                dispatchGroup.leave()
                continue
            }

            var request = URLRequest(url: url)
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            URLSession.shared.dataTask(with: request) { data, _, error in
                defer { dispatchGroup.leave() }

                guard let data = data, error == nil else {
                    print("Error fetching \(symbol): \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                do {
                    let response = try JSONDecoder().decode(NetworkResponse.self, from: data)
                    let assetData = response.data
 
                    let crypto = Cryptocurrency(
                        name: assetData.name.uppercased(),
                        symbol: symbol,
                        price: assetData.marketData.priceUsd ?? 0,
                        priceChange1h: assetData.marketData.priceChange1h ?? 0,
                        priceChange24h: assetData.marketData.priceChange24h ?? 0,
                        supply: assetData.supply,
                        marketCap: assetData.marketcap,
                        iconName: Cryptocurrency.icon(for: symbol)
                    )

                    cryptocurrencies.append(crypto)
                } catch {
                    print("Error parsing \(symbol) JSON: \(error.localizedDescription)")
                }
            }.resume()
        }
    
        dispatchGroup.notify(queue: .main) {
            completion(cryptocurrencies)
        }
    }
}
