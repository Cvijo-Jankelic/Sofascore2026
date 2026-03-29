//
//  MatchModel.swift
//  sofascore2026
//
//  Created by akademija on 12.03.2026..
//
import Foundation

enum MatchStatus{
    case notStarted
    case inProgress
    case finished
    case halfTime

}

struct MatchModel {
    let timeText: String
    let statusText: String
    let homeTeamName: String
    let awayTeamName: String
    let homeScore: String?
    let awayScore: String?
    let homeTeamLogoUrl: String?
    let awayTeamLogoUrl: String?
    let dateText: String
    let league: LeagueModel
    let sport: Sport
    let status: MatchStatus
}
