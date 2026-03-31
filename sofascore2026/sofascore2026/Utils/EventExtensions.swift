//
//  EventExtensions.swift
//  sofascore2026
//
//  Created by akademija on 13.03.2026..
//

import UIKit
import SofaAcademic


extension Event {
    
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
    
    var timeText: String {
        Event.dateTimeFormatter.string(from: Date(timeIntervalSince1970: Double(startTimestamp)))
    }
    
    var dateText: String {
          Event.dateFormatter.string(from: Date(timeIntervalSince1970: Double(startTimestamp)))
      }
}
