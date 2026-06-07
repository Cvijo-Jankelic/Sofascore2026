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

    func fetchIncidents(eventId: Int, token: String) async throws -> [APIIncident] {
        guard let url = URL(string: "\(baseURL)/events/\(eventId)/incidents") else { throw APIError.invalidURL }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        if let http = response as? HTTPURLResponse, http.statusCode == 401 { throw APIError.unauthorized }
        return try decoder.decode([APIIncident].self, from: data)
    }

    func fetchLeagueEvents(leagueId: Int, sport: String, token: String) async throws -> [APIEvent] {
        guard let url = URL(string: "\(baseURL)/events?sport=\(sport)&leagueId=\(leagueId)") else { throw APIError.invalidURL }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        if let http = response as? HTTPURLResponse, http.statusCode == 401 { throw APIError.unauthorized }
        return try decoder.decode([APIEvent].self, from: data)
    }

    func fetchStandings(leagueId: Int, token: String) async throws -> [APIStandingRow] {
        guard let url = URL(string: "\(baseURL)/leagues/\(leagueId)/standings") else { throw APIError.invalidURL }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        if let http = response as? HTTPURLResponse, http.statusCode == 401 { throw APIError.unauthorized }
        return try decoder.decode([APIStandingRow].self, from: data)
    }

    func fetchTeam(teamId: Int, token: String) async throws -> APITeamDetails {
        guard let url = URL(string: "\(baseURL)/teams/\(teamId)") else { throw APIError.invalidURL }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        if let http = response as? HTTPURLResponse, http.statusCode == 401 { throw APIError.unauthorized }
        return try decoder.decode(APITeamDetails.self, from: data)
    }

    func fetchPlayers(teamId: Int, token: String) async throws -> [APIPlayer] {
        guard let url = URL(string: "\(baseURL)/teams/\(teamId)/players") else { throw APIError.invalidURL }
        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        let (data, response) = try await URLSession.shared.data(for: request)
        if let http = response as? HTTPURLResponse, http.statusCode == 401 { throw APIError.unauthorized }
        return try decoder.decode([APIPlayer].self, from: data)
    }
}
