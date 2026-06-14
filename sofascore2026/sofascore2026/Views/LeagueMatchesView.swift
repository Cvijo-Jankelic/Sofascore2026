//
//  LeagueMatchesView.swift
//  sofascore2026
//
//  Created by akademija on 4.06.2026..

import UIKit
import SnapKit
import SofaAcademic

final class LeagueMatchesView: BaseView {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var sections: [(round: String, matches: [MatchModel])] = []

    var onMatchTapped: ((MatchModel) -> Void)?

    override func addViews() {
        addSubview(tableView)
    }

    override func styleViews() {
        backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 56
        tableView.register(MatchRowTableViewCell.self, forCellReuseIdentifier: MatchRowTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupConstraints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func configure(with sections: [(round: String, matches: [MatchModel])]) {
        self.sections = sections
        tableView.reloadData()
    }
}

extension LeagueMatchesView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < sections.count else { return 0 }
        return sections[section].matches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MatchRowTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? MatchRowTableViewCell,
              indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].matches.count
        else { return UITableViewCell() }
        cell.configure(with: sections[indexPath.section].matches[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < sections.count else { return nil }
        let label = UILabel()
        label.text = sections[section].round
        label.font = .countryName
        label.textColor = .secondaryText
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 32 }
}

extension LeagueMatchesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].matches.count else { return }
        onMatchTapped?(sections[indexPath.section].matches[indexPath.row])
    }
}
