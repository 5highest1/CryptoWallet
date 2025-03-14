import UIKit


final class CryptoDetailRouter {
    private weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }

    func goBack() {
        navigationController?.popViewController(animated: true)
    }
}


