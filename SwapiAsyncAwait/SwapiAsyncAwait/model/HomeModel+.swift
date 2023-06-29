import UIKit
extension HomeModel {
    static func create(response: SwapiResponse) -> HomeModel{
        HomeModel(count: response.count, next: response.next, list: response.results)
    }
}
extension Figure {
    var iconColor: CGColor {
        switch(gender) {
            case "male":
                return UIColor(red: 124/255, green: 208/255, blue: 245/255, alpha: 1).cgColor
            case "female":
                return UIColor(red: 255/255, green: 188/255, blue: 212/255, alpha: 1).cgColor
            case "n/a": //ROBOT
                return UIColor(red: 162/255, green: 159/255, blue: 195/255, alpha: 1).cgColor
            case "hermaphrodite":
                return UIColor(red: 106/255, green: 14/255, blue: 186/255, alpha: 1).cgColor
            case "none":
                return UIColor(red: 235/255, green: 212/255, blue: 136/255, alpha: 1).cgColor
            default:
                return UIColor(red: 229/255, green: 145/255, blue: 69/255, alpha: 1).cgColor
        }
        }

    var iconText: String {
        name.prefix(2).uppercased()
    }
}
    //    mutating func append(ids: [Figure]) {
    //        list.append(contentsOf: ids)
    //        }
    //
    //    mutating func update() -> {
    //        do {
    //            async let news = try await Swapi.getHome(url: self.next ?? "")
    //            self.next = try await news?.next
    //            self.append( try await news?.list ?? [])
    //                        } catch(let error){ debugPrint(error) }
    //        }
    //    }

