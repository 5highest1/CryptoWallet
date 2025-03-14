import UIKit


final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var delegate: AppCoordinator?

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let cryptoListRouter = CryptoListRouter(navigationController: navigationController, homeCoordinator: self)
        let cryptoListVC = CryptoListAssembly.view(router: cryptoListRouter)
        navigationController.setViewControllers([cryptoListVC], animated: true)
    }

    func logOut() {
        delegate?.logOut()
    }
}




