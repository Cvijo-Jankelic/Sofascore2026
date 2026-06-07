//
//  ApiModels.swift
//  sofascore2026
//
//  Created by akademija on 09.05.2026..
//

import Foundation

struct APICountry: Codable, Sendable {
    let name: String
}

struct APITeam: Codable, Sendable {
    let id: Int
    let name: String
    let logoUrl: String
    let country: APICountry?
}

struct APILeague: Codable, Sendable {
    let id: Int
    let name: String
    let country: APICountry?
    let logoUrl: String
    let seasonId: Int?
}

enum APIEventStatus: String, Codable, Sendable {
    case notStarted = "NOT_STARTED"
    case inProgress = "IN_PROGRESS"
    case halfTime   = "HALF_TIME"
    case finished   = "FINISHED"
}

struct APIEvent: Codable, Sendable {
    let id: Int
    let homeTeam: APITeam
    let awayTeam: APITeam
    let startTimestamp: Int
    let status: APIEventStatus
    let league: APILeague?
    let homeScore: Int?
    let awayScore: Int?
    let round: Int?
}

struct APILoginResponse: Decodable, Sendable {
    let token: String
    let name: String
}

// MARK: - Incidents

enum APIIncidentType: String, Codable, Sendable {
    case goal       = "GOAL"
    case yellowCard = "YELLOW_CARD"
    case redCard    = "RED_CARD"
    case foul       = "FOUL"
    case periodEnd  = "PERIOD_END"
    case unknown

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(String.self)
        self = APIIncidentType(rawValue: value) ?? .unknown
    }
}

struct APIIncident: Codable, Sendable {
    let type: APIIncidentType
    let minute: Int
    let isHomeTeam: Bool?
    let player: String?
    let scoreDiff: Int?
    let score: String?
    let description: String?
    let extraMinute: Int?
}

// MARK: - Standings

struct APIStandingRow: Codable, Sendable {
    let team: APITeam
    let position: Int
    let matches: Int
    let wins: Int
    let draws: Int
    let losses: Int
    let points: Int
    let scoreFor: Int
    let scoreAgainst: Int
}

// MARK: - Team Details

struct APIManager: Codable, Sendable {
    let id: Int
    let name: String
}

struct APIVenue: Codable, Sendable {
    let name: String
    let capacity: Int?
}

struct APITeamDetails: Codable, Sendable {
    let team: APITeam
    let manager: APIManager?
    let venue: APIVenue?
}

// MARK: - Players

struct APIPlayer: Codable, Sendable {
    let id: Int
    let name: String
    let position: String?
    let jerseyNumber: String?
}
