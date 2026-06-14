//
//  LeagueDetailView.swift
//  sofascore2026
//
//  Created by akademija on 4.06.2026..

import UIKit
import SnapKit
import SofaAcademic

final class LeagueDetailView: BaseView {

    private let tabBar = UISegmentedControl(items: ["Matches", "Standings"])
    let matchesView = LeagueMatchesView()
    let standingsView = LeagueStandingsView()

    var onMatchTapped: ((MatchModel) -> Void)? {
        get { matchesView.onMatchTapped }
        set { matchesView.onMatchTapped = newValue }
    }

    var onTeamTapped: ((Int, String, String?) -> Void)? {
        get { standingsView.onTeamTapped }
        set { standingsView.onTeamTapped = newValue }
    }

    override func addViews() {
        addSubview(tabBar)
        addSubview(matchesView)
        addSubview(standingsView)
    }

    override func styleViews() {
        backgroundColor = .white
        tabBar.selectedSegmentIndex = 0
        standingsView.isHidden = true
    }

    override func setupConstraints() {
        tabBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        matchesView.snp.makeConstraints {
            $0.top.equalTo(tabBar.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        standingsView.snp.makeConstraints {
            $0.top.equalTo(tabBar.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func setupGestureRecognizers() {
        tabBar.addTarget(self, action: #selector(tabChanged), for: .valueChanged)
    }

    @objc private func tabChanged() {
        let showMatches = tabBar.selectedSegmentIndex == 0
        matchesView.isHidden = !showMatches
        standingsView.isHidden = showMatches
    }
}
