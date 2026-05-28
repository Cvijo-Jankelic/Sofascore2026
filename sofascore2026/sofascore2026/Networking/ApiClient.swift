import Foundation

enum APIError: Error {
    case unauthorized
    case invalidURL
}

final class APIClient {
    static let shared = APIClient()
    private init() {}

    private let baseURL = "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"
    private let decoder = JSONDecoder()

    func login(username: String, password: String) async throws -> APILoginResponse {
        guard let url = URL(string: "\(baseURL)/login") else { throw APIError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: ["username": username, "password": password])
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decoder.decode(APILoginResponse.self, from: data)
    }

    func fetchEvents(sport: String, token: String) async throws -> [APIEvent] {
        guard let url = URL(string: "\(baseURL)/events?sport=\(sport)") else { throw APIError.invalidURL }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        if let http = response as? HTTPURLResponse, http.statusCode == 401 {
            throw APIError.unauthorized
        }
        return try decoder.decode([APIEvent].self, from: data)
    }
}
