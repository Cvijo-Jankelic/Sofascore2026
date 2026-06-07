import UIKit
import SnapKit
import SofaAcademic

final class LeagueStandingsView: BaseView {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var rows: [StandingRowModel] = []

    var onTeamTapped: ((Int, String, String?) -> Void)?

    override func addViews() {
        addSubview(tableView)
    }

    override func styleViews() {
        backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 48

        let header = StandingHeaderView()
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 48)
        tableView.tableHeaderView = header

        tableView.register(StandingTableViewCell.self, forCellReuseIdentifier: StandingTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func setupConstraints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func configure(with rows: [StandingRowModel]) {
        self.rows = rows
        tableView.reloadData()
    }
}

extension LeagueStandingsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: StandingTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? StandingTableViewCell else { return UITableViewCell() }
        cell.configure(with: rows[indexPath.row])
        return cell
    }
}

extension LeagueStandingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.row < rows.count else { return }
        let row = rows[indexPath.row]
        onTeamTapped?(row.teamId, row.teamName, row.teamLogoUrl)
    }
}
