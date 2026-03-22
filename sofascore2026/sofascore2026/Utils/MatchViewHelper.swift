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

    static func scoreColor(isLive: Bool) -> UIColor {
        return isLive ? .liveRed : .primaryText
    }

    static func teamColor(isFinished: Bool, homeScore: Int?, awayScore: Int?, side: TeamSide) -> UIColor {
            guard isFinished,
                  let homeScore,
                  let awayScore else {
                return .primaryText
            }

        switch side {
        case .home:
            return homeScore < awayScore ? .secondaryText : .primaryText
        case .away:
            return homeScore < awayScore ? .secondaryText : .primaryText
        }
    }
}
