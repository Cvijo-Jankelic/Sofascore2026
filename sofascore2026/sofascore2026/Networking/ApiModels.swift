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
}
