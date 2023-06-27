import UIKit
extension UINavigationController {
    static func create(_ rootViewController: UIViewController) -> UINavigationController{
        let nav = UINavigationController(rootViewController: rootViewController)
        return nav
    }
}
