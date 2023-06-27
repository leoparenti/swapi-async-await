import UIKit

class HomeTableViewCell: UITableViewCell {
    public var action: (() -> Void)?
    static let cellReuseIdentifier = "HomeTableViewCell"

    let mainStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .horizontal
        stackview.alignment = .fill
        return stackview
    }()

    let vStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.layoutMargins = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 0)
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.spacing = 0
        return stackview
    }()

    let vStackViewTrailing: UIStackView = {
        let stackview = UIStackView()
        stackview.layoutMargins = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 8)
        stackview.isLayoutMarginsRelativeArrangement = true
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.alignment = .trailing
        return stackview
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10.0)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    let titleCloseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10.0)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()

    let statusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()

    let statusIcon: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = 22
        label.layer.masksToBounds = true
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: HomeTableViewCell.cellReuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        backgroundColor = .white

        [titleLabel, nameLabel].forEach(vStackView.addArrangedSubview)
        [titleCloseLabel, statusLabel].forEach(vStackViewTrailing.addArrangedSubview)
        [vStackView, vStackViewTrailing, statusIcon].forEach(mainStackView.addArrangedSubview)
        contentView.addSubview(mainStackView)
        NSLayoutConstraint.activate([
            statusIcon.heightAnchor.constraint(equalToConstant: 44),
            statusIcon.heightAnchor.constraint(equalTo: statusIcon.widthAnchor),
            mainStackView.leftAnchor.constraint(equalTo:  contentView.leftAnchor),
            mainStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlerAction)))
    }

    @objc func handlerAction() {
        action?()
    }
}
