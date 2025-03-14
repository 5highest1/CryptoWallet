import UIKit


struct LoginAssembly {
    static func view(router: LoginRouter) -> LoginViewController {
        let view = LoginViewController()
        let presenter = LoginPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}

