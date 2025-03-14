import UIKit


struct CryptoDetailAssembly {
    static func view(cryptocurrency: Cryptocurrency,
                     router: CryptoDetailRouter
    ) -> UIViewController {
        let view = CryptoDetailViewController()
        let presenter = CryptoDetailPresenter(view: view, cryptocurrency: cryptocurrency, router: router)
        view.presenter = presenter
        return view
    }
}

