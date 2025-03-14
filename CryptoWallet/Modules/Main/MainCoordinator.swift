import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var appCoordinator: AppCoordinator?

    init(navigationController: UINavigationController, appCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.appCoordinator = appCoordinator
    }
    
    func start() {
        let tabBarVC = TabBarViewController()
        
        tabBarVC.tabBar.tintColor = .black

        tabBarVC.viewControllers = [
            createHomeFlow(),
            createSecondFlow(),
            createThirdFlow(),
            createFourthFlow(),
            createFifthFlow()
        ]
        navigationController.setViewControllers([tabBarVC], animated: true)
    }
    
    private func createHomeFlow() -> UINavigationController {
        let homeNavController = UINavigationController()
        let homeCoordinator = HomeCoordinator(navigationController: homeNavController)
        homeCoordinator.delegate = appCoordinator
        homeCoordinator.start()

        let homeIcon = UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
        let homeTabBarItem = UITabBarItem(
            title: nil,
            image: homeIcon,
            selectedImage: homeIcon
        )
        homeTabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        homeTabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        homeNavController.tabBarItem = homeTabBarItem

        return homeNavController
    }

    private func createSecondFlow() -> UINavigationController {
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .lightGray
        secondVC.title = "Diagnostic"
        let secondIcon = UIImage(named: "diagnostic")?.withRenderingMode(.alwaysTemplate)
        let secondTabBarItem = UITabBarItem(
            title: nil,
            image: secondIcon,
            selectedImage: secondIcon
        )
        secondTabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        secondTabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        secondVC.tabBarItem = secondTabBarItem

        let secondNavController = UINavigationController(rootViewController: secondVC)
        return secondNavController
    }

    private func createThirdFlow() -> UINavigationController {
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .cyan
        thirdVC.title = "Wakket"

        let thirdIcon = UIImage(named: "wakket")?.withRenderingMode(.alwaysTemplate)
        let thirdTabBarItem = UITabBarItem(
            title: nil,
            image: thirdIcon,
            selectedImage: thirdIcon
        )
        thirdTabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        thirdTabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        thirdVC.tabBarItem = thirdTabBarItem

        let thirdNavController = UINavigationController(rootViewController: thirdVC)
        return thirdNavController
    }

    private func createFourthFlow() -> UINavigationController {
        let fourthVC = UIViewController()
        fourthVC.view.backgroundColor = .yellow
        fourthVC.title = "File"
        let fourthIcon = UIImage(named: "file")?.withRenderingMode(.alwaysTemplate)
        let fourthTabBarItem = UITabBarItem(
            title: nil,
            image: fourthIcon,
            selectedImage: fourthIcon
        )
        fourthTabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        fourthTabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        fourthVC.tabBarItem = fourthTabBarItem

        let fourthNavController = UINavigationController(rootViewController: fourthVC)
        return fourthNavController
    }

    private func createFifthFlow() -> UINavigationController {
        let fifthVC = UIViewController()
        fifthVC.view.backgroundColor = .magenta
        fifthVC.title = "User"
        let fifthIcon = UIImage(named: "users")?.withRenderingMode(.alwaysTemplate)
        let fifthTabBarItem = UITabBarItem(
            title: nil,
            image: fifthIcon,
            selectedImage: fifthIcon
        )
        fifthTabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        fifthTabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)  
        fifthVC.tabBarItem = fifthTabBarItem

        let fifthNavController = UINavigationController(rootViewController: fifthVC)
        return fifthNavController
    }

}

