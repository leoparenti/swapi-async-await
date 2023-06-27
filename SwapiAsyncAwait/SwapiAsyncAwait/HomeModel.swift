import Foundation
import CollectionConcurrencyKit

struct HomeModel {
    var count: Int
    var next: String?
    var list: [Figure]
    
    static func create(response: SwapiResponse) -> HomeModel{
        HomeModel(count: response.count, next: response.next, list: response.results)
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
}
