import Foundation


protocol CryptoDetailView: AnyObject {
    func updateCryptoDetails(viewModel: CryptoDetailViewModel)
}

struct CryptoDetailViewModel {
    let name: String
    let symbol: String
    let price: String
    let change1h: String
    let change24h: String
    let suply: Double
    let marketCap: Double
}

final class CryptoDetailPresenter {
    
    private let cryptocurrency: Cryptocurrency
    
    private weak var view: CryptoDetailView?
    private var router: CryptoDetailRouter?
    
    init(view: CryptoDetailView,
         cryptocurrency: Cryptocurrency,
         router: CryptoDetailRouter) {
        
        self.view = view
        self.cryptocurrency = cryptocurrency
        self.router = router
    }
    
    func loadCryptoDetails() {
        let formattedPrice = String(format: "%.2f", cryptocurrency.price)
        let formattedChange1h = String(format: "%.2f", cryptocurrency.priceChange1h)
        let formattedChange24h = String(format: "%.2f", cryptocurrency.priceChange24h)
        
        
        
        view?.updateCryptoDetails(viewModel: CryptoDetailViewModel(name: cryptocurrency.name,
                                                                   symbol: cryptocurrency.symbol,
                                                                   price: "\(formattedPrice)",
                                                                   change1h: "\(formattedChange1h)",
                                                                   change24h: "\(formattedChange24h)",
                                                                   suply: cryptocurrency.supply.circulating,
                                                                   marketCap: cryptocurrency.marketCap.currentMarketcapUsd ?? 0))
    }
    
    func goBack() {
        router?.goBack()
    }
    
}
