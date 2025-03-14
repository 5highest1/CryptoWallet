import UIKit

final class TabBarViewController: UITabBarController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
    }

}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
}
