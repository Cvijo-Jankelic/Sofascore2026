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
        Event.dateTimeFormatter.string(from: Date(timeIntervalSince1970: Double(startTimestamp)))
    }
    
    private static let dateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
        
    }()
    
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
    
    var dateText: String {
        let date = Date(timeIntervalSince1970: TimeInterval(startTimestamp))
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy."
        return formatter.string(from: date)
    }
}
