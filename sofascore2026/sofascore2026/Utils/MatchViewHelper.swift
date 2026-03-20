//
//  MatchViewHelper.swift
//  sofascore2026
//
//  Created by akademija on 17.03.2026..
//

import UIKit
import SofaAcademic

enum TeamSide {
    case home
    case away
}

struct MatchViewHelper {

    static func scoreColor(for event: Event) -> UIColor {
        return event.status == .inProgress ? .liveRed : .primaryText
    }

    static func teamColor(for event: Event, side: TeamSide) -> UIColor {
        guard event.status == .finished,
              let home = event.homeScore,
              let away = event.awayScore else {
            return .primaryText
        }

        switch side {
        case .home:
            return home < away ? .secondaryText : .primaryText
        case .away:
            return away < home ? .secondaryText : .primaryText
        }
    }
}
