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
            "ETH": "RubleIcon",
            "TRX": "RubleIcon",
            "LUNA": "RubleIcon",
            "DOT": "RubleIcon",
            "DOGE": "RubleIcon",
            "USDT": "RubleIcon",
            "XLM": "RubleIcon",
            "ADA": "RubleIcon",
            "XRP": "RubleIcon"
        ]
        return iconMapping[symbol, default: "default_icon"]
    }
}
