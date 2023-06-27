struct SwapiResponse: Codable {
    let count: Int
    let next: String?
    let results: [Figure]
}
