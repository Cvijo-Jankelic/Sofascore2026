//
//  ApiClient.swift
//  sofascore2026
//
//  Created by akademija on 09.05.2026..
//

import Foundation
import Alamofire

final class APIClient {
    private let baseURL = "https://sofascore-ios-academy-be-c63faa1a2212.herokuapp.com"

    func fetchEvents(sport: String) async throws -> [APIEvent] {
        try await withCheckedThrowingContinuation { continuation in
            AF.request("\(baseURL)/events?sport=\(sport)")
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let events = try JSONDecoder().decode([APIEvent].self, from: data)
                            continuation.resume(returning: events)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }

    func login(username: String, password: String) async throws -> APILoginResponse {
        struct Body: Encodable { let username: String; let password: String }
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                "\(baseURL)/login",
                method: .post,
                parameters: Body(username: username, password: password),
                encoder: JSONParameterEncoder.default
            )
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let result = try JSONDecoder().decode(APILoginResponse.self, from: data)
                        continuation.resume(returning: result)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    func fetchSecureEvents(sport: String, token: String) async throws -> [APIEvent] {
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return try await withCheckedThrowingContinuation { continuation in
            AF.request("\(baseURL)/secure/events?sport=\(sport)", headers: headers)
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        do {
                            let events = try JSONDecoder().decode([APIEvent].self, from: data)
                            continuation.resume(returning: events)
                        } catch {
                            continuation.resume(throwing: error)
                        }
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
