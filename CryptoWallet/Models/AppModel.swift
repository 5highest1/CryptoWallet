import Foundation


struct Cryptocurrency: Codable {
    let name: String
    let symbol: String
    let price: Double
    let priceChange1h: Double
    let priceChange24h: Double
    let supply: Supply
    let marketCap: Marketcap
    let iconName: String

    static func icon(for symbol: String) -> String {
        let iconMapping = [
            "BTC": "bitcoin",
            "ETH": "bitcoin",
            "TRX": "bitcoin",
            "LUNA": "bitcoin",
            "DOT": "bitcoin",
            "DOGE": "bitcoin",
            "USDT": "bitcoin",
            "XLM": "bitcoin",
            "ADA": "bitcoin",
            "XRP": "bitcoin"
        ]
        return iconMapping[symbol, default: "default_icon"]
    }
}
