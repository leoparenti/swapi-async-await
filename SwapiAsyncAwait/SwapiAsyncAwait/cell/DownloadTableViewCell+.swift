import UIKit
extension DownloadTableViewCell {
    func configure(_ action: @escaping (() -> Void)){
        textLabel?.text = "download"
        textLabel?.textAlignment = .center
        self.action = action
    }
}
