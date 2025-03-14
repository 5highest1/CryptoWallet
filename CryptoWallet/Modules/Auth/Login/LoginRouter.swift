import UIKit


final class LoginRouter {
    private var navigationController: UINavigationController?
    private var authCoordinator: AuthCoordinator?

    init(navigationController: UINavigationController?, authCoordinator: AuthCoordinator) {
        self.navigationController = navigationController
        self.authCoordinator = authCoordinator
    }

    func startMainFlow() {
        authCoordinator?.loginSuccessful()
    }

    func showError(message: String) {
        print(message)
    }
}


