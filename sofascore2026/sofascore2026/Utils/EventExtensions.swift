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
}
