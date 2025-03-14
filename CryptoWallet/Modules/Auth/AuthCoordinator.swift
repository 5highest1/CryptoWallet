import UIKit


final class AuthCoordinator: Coordinator {
    var navigationController: UINavigationController
    var didFinishAuth: (() -> Void)?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let router = LoginRouter(navigationController: navigationController, authCoordinator: self)
        let loginVC = LoginAssembly.view(router: router)
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func loginSuccessful() {
        didFinishAuth?()
    }
}



