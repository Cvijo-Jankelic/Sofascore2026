import UIKit
import SnapKit
import SofaAcademic

final class IncidentsView: BaseView {

    private let tableView = UITableView(frame: .zero, style: .plain)
    private var incidents: [IncidentModel] = []

    override func addViews() {
        addSubview(tableView)
    }

    override func styleViews() {
        backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.register(IncidentTableViewCell.self, forCellReuseIdentifier: IncidentTableViewCell.reuseIdentifier)
        tableView.register(IncidentPeriodTableViewCell.self, forCellReuseIdentifier: IncidentPeriodTableViewCell.reuseIdentifier)
        tableView.dataSource = self
    }

    override func setupConstraints() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    func configure(with incidents: [IncidentModel]) {
        self.incidents = incidents
        tableView.reloadData()
        tableView.layoutIfNeeded()
    }
}

extension IncidentsView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        incidents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = incidents[indexPath.row]

        if case let .period(text) = model.type {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: IncidentPeriodTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? IncidentPeriodTableViewCell else { return UITableViewCell() }
            cell.configure(with: text)
            return cell
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: IncidentTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? IncidentTableViewCell else { return UITableViewCell() }
        cell.configure(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = incidents[indexPath.row]
        if case .period = model.type { return 40 }
        return 56
    }
}
