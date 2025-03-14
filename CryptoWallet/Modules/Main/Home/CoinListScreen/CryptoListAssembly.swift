import UIKit


struct CryptoListAssembly {
    static func view(router: CryptoListRouter
    ) -> UIViewController {
        let view = CryptoListViewController()
        let presenter = CryptoListPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}

