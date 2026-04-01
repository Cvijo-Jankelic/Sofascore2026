//
//  MatchModel+UI.swift
//  sofascore2026
//
//  Created by akademija on 29.03.2026..
//

import UIKit

extension MatchModel {
    
    var statusColor: UIColor {
        switch status {
        case .inProgress, .halfTime: return .liveRed
        case .finished, .notStarted: return .secondaryText
        }
    }
    
    var scoreColor: UIColor {
        switch status {
        case .inProgress, .halfTime: return .liveRed
        case .finished, .notStarted: return .primaryText
        }
    }
    
    var homeTeamColor: UIColor {
        guard case .finished = status else { return .primaryText }
        let home = homeScore.flatMap { Int($0) } ?? 0
        let away = awayScore.flatMap { Int($0) } ?? 0
        return home >= away ? .primaryText : .secondaryText
    }
    
    var awayTeamColor: UIColor {
        guard case .finished = status else { return .primaryText }
        let home = homeScore.flatMap { Int($0) } ?? 0
        let away = awayScore.flatMap { Int($0) } ?? 0
        return away >= home ? .primaryText : .secondaryText
    }
    
    var homeScoreColor: UIColor {
        switch status {
        case .inProgress, .halfTime: return .liveRed
        case .notStarted: return .primaryText
        case .finished:
            let home = homeScore.flatMap { Int($0) } ?? 0
            let away = awayScore.flatMap { Int($0) } ?? 0
            return home >= away ? .primaryText : .secondaryText
        }
    }

    var awayScoreColor: UIColor {
        switch status {
        case .inProgress, .halfTime: return .liveRed
        case .notStarted: return .primaryText
        case .finished:
            let home = homeScore.flatMap { Int($0) } ?? 0
            let away = awayScore.flatMap { Int($0) } ?? 0
            return away >= home ? .primaryText : .secondaryText
        }
    }
}
