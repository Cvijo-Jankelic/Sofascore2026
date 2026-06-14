//
//  IncidentType.swift
//  sofascore2026
//
//  Created by akademija on 4.06.2026..
//
import Foundation

enum IncidentType {
    case goalHome(playerName: String, homeScore: Int, awayScore: Int, minute: Int, scoreDiff: Int)
    case goalAway(playerName: String, homeScore: Int, awayScore: Int, minute: Int, scoreDiff: Int)
    case yellowCardHome(playerName: String, minute: Int, description: String?)
    case yellowCardAway(playerName: String, minute: Int, description: String?)
    case redCardHome(playerName: String, minute: Int, description: String?)
    case redCardAway(playerName: String, minute: Int, description: String?)
    case defaultHome(playerName: String, description: String?, minute: Int)
    case defaultAway(playerName: String, description: String?, minute: Int)
    case period(text: String)
}

struct IncidentModel {
    let id: Int
    let type: IncidentType
    let sport: Sport
}
