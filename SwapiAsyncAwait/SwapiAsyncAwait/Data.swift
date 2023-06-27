import Foundation

struct SwapiResponse: Codable {
    let count: Int
    let next: String?
    let results: [Figure]
}

// People
public struct Figure: Codable, Hashable {
    let birthYear, created, edited, eyeColor: String
    let films: [String]
    let gender: String
    let hairColor, height: String
    let homeworld: String
    let mass, name, skinColor: String
    let species, starships: [String]
    let url: String
    let vehicles: [String]

    enum CodingKeys: String, CodingKey {
        case birthYear = "birth_year"
        case created, edited
        case eyeColor = "eye_color"
        case films, gender
        case hairColor = "hair_color"
        case height, homeworld, mass, name
        case skinColor = "skin_color"
        case species, starships, url, vehicles
    }
}

public struct Vehicle: Codable, Hashable {
    let cargoCapacity, consumables, costInCredits, created: String
    let crew, edited: String
    let films: [String]
    let length, manufacturer, maxAtmospheringSpeed, model: String
    let name, passengers: String
    let pilots: [String]
    let url: String
    let vehicleClass: String

    enum CodingKeys: String, CodingKey {
        case cargoCapacity = "cargo_capacity"
        case consumables
        case costInCredits = "cost_in_credits"
        case created, crew, edited, films, length, manufacturer
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case model, name, passengers, pilots, url
        case vehicleClass = "vehicle_class"
    }
}

struct Film: Codable {
    let title: String
    let characters: [String]
    let created, director, edited: String
    let episodeID: Int
    let openingCrawl: String
    let planets: [String]
    let producer, releaseDate: String
    let species, starships: [String]
    let url: String
    let vehicles: [String]

    enum CodingKeys: String, CodingKey {
        case characters, created, director, edited
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case planets, producer
        case releaseDate = "release_date"
        case species, starships, title, url, vehicles
    }
}
