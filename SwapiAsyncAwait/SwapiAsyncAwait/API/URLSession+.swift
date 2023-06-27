import Foundation
enum URLSessionAsyncError: Error {
    case wrongUrl, noData, decode(Error)
}
public extension URLSession {
    func asyncData(for request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation({ continuation in
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                }
                guard let response = response as? HTTPURLResponse else {
                    continuation.resume(throwing: URLSessionAsyncError.wrongUrl)
                    return
                }
                guard let data = data else {
                    continuation.resume(throwing: URLSessionAsyncError.noData)
                    return
                }
                continuation.resume(returning: (data, response))
            }
            task.resume()
        })
    }
}
