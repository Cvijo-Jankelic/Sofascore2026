import UIKit
import SnapKit
import SofaAcademic

final class TeamSquadView: BaseView {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var players: [PlayerModel] = []

    override func addViews() {
        addSubview(tableView)
    }

    override func styleViews() {
        backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 48
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: PlayerTableViewCell.reuseIdentifier)
        tableView.dataSource = self
    }

    override func setupConstraints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func configure(with players: [PlayerModel]) {
        self.players = players
        tableView.reloadData()
    }
}

extension TeamSquadView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        players.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: PlayerTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? PlayerTableViewCell else { return UITableViewCell() }
        cell.configure(with: players[indexPath.row])
        return cell
    }
}
