import UIKit


protocol CryptoListView: AnyObject {
    func updateCryptoList(cryptos: [Cryptocurrency])
    func showError(message: String)
}

final class CryptoListPresenter {
    private weak var view: CryptoListView?
    private var router: CryptoListRouter?
    
    init(view: CryptoListView,
         router: CryptoListRouter) {
        
        self.view = view
        self.router = router
    }
    
    func fetchCryptocurrencies() {
        NetworkService.shared.fetchCryptocurrencyData
        { [weak self] cryptos in
            guard let self = self else { return }
            if let cryptos = cryptos {
                self.view?.updateCryptoList(cryptos: cryptos)
            } else {
                self.view?.showError(message: "Не удалось загрузить данные")
            }
        }
    }
    
    func didSelectCrypto(cryptocurrency: Cryptocurrency) {
        router?.navigateToCryptoDetail(cryptocurrency: cryptocurrency)
    }
    
    func logOut() {
        router?.logOut()
    }
}
