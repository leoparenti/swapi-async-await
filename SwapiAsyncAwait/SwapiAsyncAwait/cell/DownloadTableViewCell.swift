import UIKit
class DownloadTableViewCell: UITableViewCell{
    public var action: (() -> Void)?
    static let cellReuseIdentifier = "DownloadTableViewCell"

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: DownloadTableViewCell.cellReuseIdentifier)
        setup()
    }

    func setup(){
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlerAction)))
    }

    @objc func handlerAction() {
        addActivity()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            [unowned self] in
            action?()
        }
    }

    func addActivity(){
        let activity = UIActivityIndicatorView(style: .medium)
        activity.color = .purple
        activity.startAnimating()
        accessoryView = activity
    }
}
