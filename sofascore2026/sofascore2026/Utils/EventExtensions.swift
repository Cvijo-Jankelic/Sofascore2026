//
//  EventExtensions.swift
//  sofascore2026
//
//  Created by akademija on 13.03.2026..
//

import UIKit
import Foundation

extension APIEvent {

    private static let dateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy."
        return formatter
    }()

    var statusText: String {
        switch status {
        case .finished: return "FT"
        case .notStarted: return "-"
        case .halfTime: return "HT"
        case .inProgress:
            let elapsed = Date().timeIntervalSince1970 - Double(startTimestamp)
            return "\(Int(elapsed / 60))'"
        }
    }

    var timeText: String {
        APIEvent.dateTimeFormatter.string(from: Date(timeIntervalSince1970: Double(startTimestamp)))
    }

    var dateText: String {
        APIEvent.dateFormatter.string(from: Date(timeIntervalSince1970: Double(startTimestamp)))
    }

    var roundInfoText: String {
        if let round = round { return "Round \(round)" }
        return "Round"
    }

    func toMatchModel(sport: Sport, fallbackLeague: LeagueModel? = nil) -> MatchModel {
        let status: MatchStatus
        switch self.status {
        case .notStarted: status = .notStarted
        case .inProgress: status = .inProgress
        case .halfTime:   status = .halfTime
        case .finished:   status = .finished
        }
        let league = self.league?.toModel()
            ?? fallbackLeague
            ?? LeagueModel(id: 0, seasonId: nil, countryName: "", leagueName: "", logoUrl: nil)
        return MatchModel(
            eventId: self.id,
            timeText: self.timeText,
            statusText: self.statusText,
            homeTeamId: self.homeTeam.id,
            homeTeamName: self.homeTeam.name,
            awayTeamId: self.awayTeam.id,
            awayTeamName: self.awayTeam.name,
            homeScore: self.homeScore.map { "\($0)" },
            awayScore: self.awayScore.map { "\($0)" },
            homeTeamLogoUrl: self.homeTeam.logoUrl,
            awayTeamLogoUrl: self.awayTeam.logoUrl,
            dateText: self.dateText,
            league: league,
            sport: sport,
            status: status
        )
    }
}

extension APILeague {
    func toModel() -> LeagueModel {
        LeagueModel(
            id: self.id,
            seasonId: self.seasonId,
            countryName: self.country?.name ?? "",
            leagueName: self.name,
            logoUrl: self.logoUrl
        )
    }
}
