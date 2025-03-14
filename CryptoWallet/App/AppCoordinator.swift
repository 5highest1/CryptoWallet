import UIKit

protocol Coordinator {
    func start()
}

final class AppCoordinator: Coordinator {
    var window: UIWindow
    var navigationController: UINavigationController? {
        didSet {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }

    private var mainCoordinator: MainCoordinator?
    private var authCoordinator: AuthCoordinator?

    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") {
            startMainFlow()
        } else {
            startAuthFlow()
        }
    }
    
    func startAuthFlow() {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        authCoordinator = AuthCoordinator(navigationController: self.navigationController!)
        
        authCoordinator?.didFinishAuth = { [weak self] in
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            self?.startMainFlow()
        }
        
        authCoordinator?.start()
    }

    func startMainFlow() {
        navigationController = UINavigationController()
        window.rootViewController = navigationController
        
        mainCoordinator = MainCoordinator(navigationController: self.navigationController!, appCoordinator: self)
        mainCoordinator?.start()
    }

    func logOut() {
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        self.start()
    }
}


