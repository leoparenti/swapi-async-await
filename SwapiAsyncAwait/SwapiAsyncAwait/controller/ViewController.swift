import UIKit
class ViewController: UIViewController {
    var navigator: Navigator
    
    internal init(navigator: Navigator) {
            self.navigator = navigator
            super.init(nibName: nil, bundle: nil)
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
