import UIKit

struct DetailModel {
    let name: String
    let vehicles: [String]
    let films: [String]
    
    static func create(figure: Figure, vehicles: [Vehicle], films: [Film]) -> DetailModel {
        DetailModel(name: figure.name, vehicles: vehicles.map{ $0.name }, films: films.map{ $0.title })
    }
}

class DetailViewController: UIViewController {
    var model: DetailModel
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = label.font.withSize(30)
        label.backgroundColor = .red
        return label
    }()

    let detailLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = label.font.withSize(16)
        label.backgroundColor = .yellow
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        return stackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    init(model: DetailModel) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailViewController{
    private func configure() {
        titleLabel.text = model.name
        detailLabel.text = "VEHICLES\n\(model.vehicles.joined(separator: ", "))\n\nFILM\n\(model.films.joined(separator: ", "))\n"
    }
    
    private func setup(){
        view.backgroundColor = .gray
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(detailLabel)
        view.addSubview(stackView)
        NSLayoutConstraint
            .activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
    }
}
