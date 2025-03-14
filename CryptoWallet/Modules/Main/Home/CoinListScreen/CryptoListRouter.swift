import UIKit


final class CryptoListRouter {
    
    private weak var navigationController: UINavigationController?
    private var homeCoordinator: HomeCoordinator?

    init(navigationController: UINavigationController,
         homeCoordinator: HomeCoordinator) {
        self.navigationController = navigationController
        self.homeCoordinator = homeCoordinator
    }

    func navigateToCryptoDetail(cryptocurrency: Cryptocurrency) {
        let detailRouter = CryptoDetailRouter(navigationController: navigationController)
        let detailVC = CryptoDetailAssembly.view(cryptocurrency: cryptocurrency,
                                                 router: detailRouter)
        navigationController?.pushViewController(detailVC, animated: true)
    }

    func logOut() {
        homeCoordinator?.logOut()
    }
}



