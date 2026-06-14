//
//  Sport.swift
//  sofascore2026
//
//  Created by akademija on 21.03.2026..
//

enum Sport {
    case football
    case basketball
    case americanFootball

    var title: String {
        switch self {
        case .football: return "Football"
        case .basketball: return "Basketball"
        case .americanFootball: return "Am. Football"
        }
    }

    var icon: String {
        switch self {
        case .football: return "football"
        case .basketball: return "basketball"
        case .americanFootball: return "amfootball"
        }
    }

    var slug: String {
        switch self {
        case .football: return "football"
        case .basketball: return "basketball"
        case .americanFootball: return "american-football"
        }
    }
}
