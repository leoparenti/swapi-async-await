import UIKit

class HomeViewController: ViewController {
    var model: HomeModel? {
        didSet {
            if let _ = model {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(HomeTableViewCell.self,
                           forCellReuseIdentifier: HomeTableViewCell.cellReuseIdentifier)
        tableView.register(DownloadTableViewCell.self,
                           forCellReuseIdentifier: DownloadTableViewCell.cellReuseIdentifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetch()
    }

    func setup(){
        view.backgroundColor = .lightGray
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
    
    func fetch(){
        Task.init { do { model = try await Swapi.getHome() } catch(let error){ debugPrint(error) } }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (model?.list.count ?? 0) + (model?.next != nil ? 1 : 0)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == model?.list.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: DownloadTableViewCell.cellReuseIdentifier, for: indexPath) as! DownloadTableViewCell
            cell.configure { [unowned self] in
                do{
                    try getMoreFigures(next: model?.next ?? "")
                } catch(let error){ debugPrint(error) }
                 }
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.cellReuseIdentifier, for: indexPath) as! HomeTableViewCell
        if let figure = model?.list[indexPath.row] {
            cell.configure(from: figure) { [unowned self] in
                do {
                    try detailAction(figure: figure)
                } catch(let error){ debugPrint(error) }
            }
        }
        return cell
    }
}

extension HomeViewController{
    func getMoreFigures(next: String) throws {
        Task.init {
            [unowned self] in
            async let news = try await Swapi.getHome(url: next)
            model?.next = try await news?.next
            model?.list += try await news?.list ?? []
        }
    }

    func detailAction(figure: Figure) throws {
        Task.init {
            [unowned self] in
            let dmodel = try await Swapi.getDetails(url: figure.url)
            navigator.push(.detail(dmodel), from: self)
        }
    }
}
