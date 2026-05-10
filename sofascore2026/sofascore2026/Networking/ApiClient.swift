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

    func fetchEvents(sport: String, completion: @escaping (Result<[APIEvent], Error>) -> Void) {
        AF.request("\(baseURL)/events?sport=\(sport)")
            .responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let events = try JSONDecoder().decode([APIEvent].self, from: data)
                        completion(.success(events))
                    } catch {
                        completion(.failure(error))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
