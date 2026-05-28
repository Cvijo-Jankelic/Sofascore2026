import Foundation

enum APIError: Error {
    case unauthorized
}

final class APIClient {
    private let baseURL = "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"
    private let decoder = JSONDecoder()

    func login(username: String, password: String) async throws -> APILoginResponse {
        var request = URLRequest(url: URL(string: "\(baseURL)/login")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONSerialization.data(withJSONObject: ["username": username, "password": password])
        let (data, _) = try await URLSession.shared.data(for: request)
        return try decoder.decode(APILoginResponse.self, from: data)
    }

    func fetchSecureEvents(sport: String, token: String) async throws -> [APIEvent] {
        var request = URLRequest(url: URL(string: "\(baseURL)/events?sport=\(sport)")!)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        if let http = response as? HTTPURLResponse, http.statusCode == 401 {
            throw APIError.unauthorized
        }
        return try decoder.decode([APIEvent].self, from: data)
    }
}
