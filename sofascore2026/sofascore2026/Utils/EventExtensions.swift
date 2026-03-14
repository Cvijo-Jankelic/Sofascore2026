//
//  EventExtensions.swift
//  sofascore2026
//
//  Created by akademija on 13.03.2026..
//

import UIKit
import SofaAcademic

extension Event {
    var timeText: String {
        let date = Date(timeIntervalSince1970: Double(startTimestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    var statusText: String{
        switch status {
        case .finished: return "FT"
        case .notStarted: return "-"
        case .halftime: return "HT"
        case .inProgress:
            let elapsed = Date().timeIntervalSince1970 - Double(startTimestamp)
            return "\(Int(elapsed / 60))'"
        }
    }
    
    var scoreColor: UIColor {
        status == .inProgress ? .liveRed : .primaryText
    }
    
    var homeTeamColor: UIColor {
        guard status == .finished,
              let home = homeScore,
              let away = awayScore else { return .primaryText }
        return home < away ? .secondaryText : .primaryText
    }
    
    var awayTeamColor: UIColor {
        guard status == .finished,
              let home = homeScore,
              let away = awayScore else { return .primaryText }
        return away < home ? .secondaryText : .primaryText
    }
    
}
