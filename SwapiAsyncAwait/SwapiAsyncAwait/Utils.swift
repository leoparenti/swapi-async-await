import Foundation

enum SwapiError: Error {
    case wrongUrl, noData, decode(Error)
}

struct SwapiEndpoint {
    static let people = "https://gotev.github.io/swapi-android/people/page1.json"
}

public extension URLSession {
    func asyncData(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation({ continuation in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                }
                guard let response = response as? HTTPURLResponse else {
                    continuation.resume(throwing: SwapiError.wrongUrl)
                    return
                }
                guard let data = data else {
                    continuation.resume(throwing: SwapiError.noData)
                    return
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        })
    }
}

struct Swapi {
    static func getHome(url: String = SwapiEndpoint.people) async throws -> HomeModel? {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let (data, _) = try await URLSession.shared.asyncData(for: urlRequest)
        debugPrint("getHome:\(url)")
        return try HomeModel.create(response: JSONDecoder().decode(SwapiResponse.self, from: data))
    }
    
    private static func getFeature(url: String) async throws -> Figure {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let (data, _) = try await URLSession.shared.asyncData(for: urlRequest)
        debugPrint("getFeature:\(url)")
        return try JSONDecoder().decode(Figure.self, from: data)
    }
    
    private static func getVehicle(url: String) async throws -> Vehicle {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let (data, _) = try await URLSession.shared.asyncData(for: urlRequest)
        debugPrint("getVehicle:\(url)")
        return try JSONDecoder().decode(Vehicle.self, from: data)
    }
    
    private static func getFilm(url: String) async throws -> Film {
        let urlRequest = URLRequest(url: URL(string: url)!)
        let (data, _) = try await URLSession.shared.asyncData(for: urlRequest)
        debugPrint("getFilm:\(url)")
        return try JSONDecoder().decode(Film.self, from: data)
    }
    
    static func getDetails(url: String) async throws -> DetailModel {
        debugPrint("getDetails:\(url)")
        let feature =  try await Swapi.getFeature(url: url)
        async let veicoli: [Vehicle] =  feature.vehicles.asyncMap { try await Swapi.getVehicle(url: $0) }
        async let films: [Film] =  feature.films.asyncMap { try await Swapi.getFilm(url: $0) }
        return DetailModel.create(figure: feature, vehicles: try await veicoli, films: try await films)
    }
}
