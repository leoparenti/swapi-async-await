import UIKit

final class Navigator {
    enum Segue {
        case main
        case detail(DetailModel)
    }

    static let `default` = Navigator()
    private init() {}

    private func create(_ segue: Segue) -> UIViewController {
        switch segue {
            case .main:
                return UINavigationController.create(HomeViewController(navigator: self))
            case .detail(let model):
                return DetailViewController.create(model: model, navigator: self)
//            case .alert(let title, let message):
//                return UIAlertController.create(title: title,
//                                                message: message)
        }
    }
}

extension Navigator {
    func homeController() -> UIViewController{
        return create(.main)
    }

    func present(_ segue: Segue, from fromViewController: UIViewController) {
        switch segue {
            default:
                fromViewController.present(create(segue), animated: true)
        }
    }
    func push(_ segue: Segue, from fromViewController: UIViewController) {
        switch segue {
            default:
                fromViewController.navigationController?.pushViewController(create(segue), animated: true)
        }
    }
}
