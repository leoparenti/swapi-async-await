import UIKit

let cellIdentifier = "swcell"

class HomeViewController: UITableViewController {
    var model: HomeModel? {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        fetch()
    }
    
    func fetch(){
        Task.init { do { model = try await Swapi.getHome() } catch(let error){ debugPrint(error) } }
    }
            
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        if indexPath.row == model?.list.count {
            cell.textLabel?.text = "download"
            cell.textLabel?.textAlignment = .center
        }
        else if let data = model?.list[indexPath.row] {
            cell.textLabel?.text = "\(data.name) - \(data.skinColor) - \(data.mass)"
            cell.textLabel?.textAlignment = .left
        }
        return cell
    }
            
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (model?.list.count ?? 0) + (model?.next != nil ? 1 : 0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rotella(at: indexPath)
        if indexPath.row == model?.list.count {
            Task.init { do {
                async let news = try await Swapi.getHome(url: model?.next ?? "")
                self.model?.next = try await news?.next
                self.model?.list += try await news?.list ?? []
            } catch(let error){ debugPrint(error) }
            }
        }
        else if let data = model?.list[indexPath.row] {
            Task.init { do {
                let dmodel = try await Swapi.getDetails(url: data.url)
                let detail = DetailViewController(model: dmodel)
                self.present(UINavigationController(rootViewController: detail), animated: true) {
                    tableView.cellForRow(at: indexPath)?.accessoryView = nil }
            } catch(let error){ debugPrint(error) }
            }
        }
    }
    
    private func rotella( at indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let rotella = UIActivityIndicatorView(style: .medium)
        rotella.color = .purple
        rotella.startAnimating()
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryView = rotella
    }
    
}
