import UIKit
import SnapKit

final class EventDetailViewController: UIViewController {

    private let match: MatchModel
    private let headerView = EventDetailHeaderView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let eventDetailView = EventDetailView()
    private var incidents: [IncidentModel] = []

    init(match: MatchModel) {
        self.match = match
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleView()
        setupConstraints()
        configure()
        fetchIncidents()
    }

    private func addViews() {
        view.addSubview(headerView)
        view.addSubview(tableView)
    }

    private func styleView() {
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.register(IncidentTableViewCell.self, forCellReuseIdentifier: IncidentTableViewCell.reuseIdentifier)
        tableView.register(IncidentPeriodTableViewCell.self, forCellReuseIdentifier: IncidentPeriodTableViewCell.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self

        eventDetailView.configure(with: match)
        eventDetailView.onHomeTeamTapped = { [weak self] in
            guard let self else { return }
            let teamVC = TeamDetailViewController(teamId: self.match.homeTeamId, teamName: self.match.homeTeamName, teamLogoUrl: self.match.homeTeamLogoUrl)
            self.navigationController?.pushViewController(teamVC, animated: true)
        }
        eventDetailView.onAwayTeamTapped = { [weak self] in
            guard let self else { return }
            let teamVC = TeamDetailViewController(teamId: self.match.awayTeamId, teamName: self.match.awayTeamName, teamLogoUrl: self.match.awayTeamLogoUrl)
            self.navigationController?.pushViewController(teamVC, animated: true)
        }

        eventDetailView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120)
        tableView.tableHeaderView = eventDetailView
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configure() {
        headerView.configure(with: match)
        headerView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func fetchIncidents() {
        guard let token = AuthService.shared.token else { return }
        Task {
            do {
                let apiIncidents = try await APIClient.shared.fetchIncidents(eventId: match.eventId, token: token)
                incidents = makeIncidentModels(from: apiIncidents)
                tableView.reloadData()
            } catch {
                print("Incidents fetch error: \(error)")
            }
        }
    }

    private func makeIncidentModels(from apiIncidents: [APIIncident]) -> [IncidentModel] {
        print("📋 Incidents: \(apiIncidents.map { "\($0.type) min:\($0.minute) player:\($0.player ?? "nil")" })")
        return apiIncidents.enumerated().compactMap { index, incident in
            let id = index
            let sport = match.sport
            let playerName = incident.player ?? ""
            let isHome = incident.isHomeTeam == true

            switch incident.type {
            case .goal:
                let scores = parseScore(incident.score)
                let diff = incident.scoreDiff ?? 1
                if isHome {
                    return IncidentModel(id: id, type: .goalHome(playerName: playerName, homeScore: scores.home, awayScore: scores.away, minute: incident.minute, scoreDiff: diff), sport: sport)
                } else {
                    return IncidentModel(id: id, type: .goalAway(playerName: playerName, homeScore: scores.home, awayScore: scores.away, minute: incident.minute, scoreDiff: diff), sport: sport)
                }

            case .yellowCard:
                if isHome {
                    return IncidentModel(id: id, type: .yellowCardHome(playerName: playerName, minute: incident.minute, description: incident.description), sport: sport)
                } else {
                    return IncidentModel(id: id, type: .yellowCardAway(playerName: playerName, minute: incident.minute, description: incident.description), sport: sport)
                }

            case .redCard:
                if isHome {
                    return IncidentModel(id: id, type: .redCardHome(playerName: playerName, minute: incident.minute, description: incident.description), sport: sport)
                } else {
                    return IncidentModel(id: id, type: .redCardAway(playerName: playerName, minute: incident.minute, description: incident.description), sport: sport)
                }

            case .periodEnd:
                let text = incident.description ?? incident.score ?? ""
                return IncidentModel(id: id, type: .period(text: text), sport: sport)

            default:
                if isHome {
                    return IncidentModel(id: id, type: .defaultHome(playerName: playerName, description: incident.description, minute: incident.minute), sport: sport)
                } else {
                    return IncidentModel(id: id, type: .defaultAway(playerName: playerName, description: incident.description, minute: incident.minute), sport: sport)
                }
            }
        }
    }

    private func parseScore(_ score: String?) -> (home: Int, away: Int) {
        guard let score = score else { return (0, 0) }
        let parts = score.split(separator: "-").map { $0.trimmingCharacters(in: .whitespaces) }
        guard parts.count == 2,
              let home = Int(parts[0]),
              let away = Int(parts[1]) else { return (0, 0) }
        return (home, away)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

extension EventDetailViewController: UITableViewDataSource {
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
}

extension EventDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if case .period = incidents[indexPath.row].type { return 40 }
        return 56
    }
}
