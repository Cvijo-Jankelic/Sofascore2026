//
//  LeagueModel.swift
//  sofascore2026
//
//  Created by akademija on 12.03.2026..
//
struct LeagueModel{
    let countryName: String
    let leagueName: String
    let logoUrl: String?
}

struct LeagueSectionModel {
    let id: Int
    let league: LeagueModel
    var matches: [MatchModel]
}
