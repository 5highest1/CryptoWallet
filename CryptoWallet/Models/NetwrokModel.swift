import Foundation


struct NetworkResponse: Codable {
    let data: AssetData
}

struct AssetData: Codable {
    let symbol: String
    let name: String
    let marketData: MarketData
    let marketcap: Marketcap
    let supply: Supply

    enum CodingKeys: String, CodingKey {
        case symbol
        case name
        case marketData = "market_data"
        case marketcap, supply
    }
}

struct Marketcap: Codable {
    let marketcapDominancePercent, currentMarketcapUsd: Double?
    let realizedMarketcapUsd, outstandingMarketcapUsd: Double?

    enum CodingKeys: String, CodingKey {
        case marketcapDominancePercent = "marketcap_dominance_percent"
        case currentMarketcapUsd = "current_marketcap_usd"
        case realizedMarketcapUsd = "realized_marketcap_usd"
        case outstandingMarketcapUsd = "outstanding_marketcap_usd"
    }
}

struct MarketData: Codable {
    let priceUsd: Double?
    let priceChange1h: Double?
    let priceChange24h: Double?

    enum CodingKeys: String, CodingKey {
        case priceUsd = "price_usd"
        case priceChange1h = "percent_change_usd_last_1_hour"
        case priceChange24h = "percent_change_usd_last_24_hours"
    }
}

struct Supply: Codable {
    let circulating: Double

    enum CodingKeys: String, CodingKey {
        case circulating
    }
}
