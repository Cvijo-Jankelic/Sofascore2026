import UIKit
import SnapKit

class HomeViewController: UIViewController {
    private let appHeaderView = AppHeaderView()
    private let sportSelectorView = SportSelectorView()
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let apiClient = APIClient()

    private var selectedSport: Sport = .football {
        didSet {
            fetchEvents(for: selectedSport)
        }
    }

    private var sections: [LeagueSectionModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleView()
        setupConstraints()
        configure()
    }

    private func addViews() {
        view.addSubview(appHeaderView)
        view.addSubview(sportSelectorView)
        view.addSubview(tableView)
    }

    private func styleView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 56
        tableView.register(MatchRowTableViewCell.self, forCellReuseIdentifier: MatchRowTableViewCell.reuseIdentifier)
        tableView.register(HeaderLeagueTableWrapper.self, forHeaderFooterViewReuseIdentifier: HeaderLeagueTableWrapper.reuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self

        sportSelectorView.configure(selectedSport: selectedSport)
        sportSelectorView.onSportSelected = { [weak self] sport in
            self?.selectedSport = sport
        }
    }

    private func setupConstraints() {
        appHeaderView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(48)
        }

        sportSelectorView.snp.makeConstraints {
            $0.top.equalTo(appHeaderView.snp.bottom)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(sportSelectorView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func configure() {
        appHeaderView.onSettingsTapped = { [weak self] in
            let settingsVC = SettingsViewController()
            settingsVC.modalPresentationStyle = .fullScreen
            self?.present(settingsVC, animated: true)
        }
        fetchEvents(for: selectedSport)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    private func fetchEvents(for sport: Sport) {
        sportSelectorView.updateSelection(to: sport)
        guard let token = AuthService.shared.token else { return }
        Task {
            do {
                let apiEvents = try await apiClient.fetchSecureEvents(sport: sport.slug, token: token)
                for event in apiEvents {
                    if let league = event.league { DatabaseManager.shared.saveLeague(league) }
                    DatabaseManager.shared.saveEvent(event, sport: sport.slug)
                }
                sections = makeSections(from: apiEvents, sport: sport)
                tableView.reloadData()
            } catch {
                print("Fetch error: \(error)")
            }
        }
    }

    private func makeSections(from events: [APIEvent], sport: Sport) -> [LeagueSectionModel] {
        var orderedSections: [LeagueSectionModel] = []
        events.forEach { event in
            guard let league = event.league else { return }
            let leagueId = league.id
            if let index = orderedSections.firstIndex(where: { $0.id == leagueId }) {
                orderedSections[index].matches.append(makeMatchModel(from: event, sport: sport))
            } else {
                let section = LeagueSectionModel(
                    id: leagueId,
                    league: makeLeagueModel(from: league),
                    matches: [makeMatchModel(from: event, sport: sport)]
                )
                orderedSections.append(section)
            }
        }
        return orderedSections
    }

    private func makeLeagueModel(from league: APILeague) -> LeagueModel {
        LeagueModel(
            countryName: league.country?.name ?? "",
            leagueName: league.name,
            logoUrl: league.logoUrl
        )
    }

    private func makeMatchModel(from event: APIEvent, sport: Sport) -> MatchModel {
        let status: MatchStatus
        switch event.status {
        case .notStarted: status = .notStarted
        case .inProgress: status = .inProgress
        case .halfTime: status = .halfTime
        case .finished: status = .finished
        }

        return MatchModel(
            timeText: event.timeText,
            statusText: event.statusText,
            homeTeamName: event.homeTeam.name,
            awayTeamName: event.awayTeam.name,
            homeScore: event.homeScore.map { "\($0)" },
            awayScore: event.awayScore.map { "\($0)" },
            homeTeamLogoUrl: event.homeTeam.logoUrl,
            awayTeamLogoUrl: event.awayTeam.logoUrl,
            dateText: event.dateText,
            league: event.league.map { makeLeagueModel(from: $0) } ?? LeagueModel(countryName: "", leagueName: "", logoUrl: nil),
            sport: sport,
            status: status
        )
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < sections.count else { return 0 }
        return sections[section].matches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchRowTableViewCell.reuseIdentifier, for: indexPath) as? MatchRowTableViewCell,
              indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].matches.count else {
            return UITableViewCell()
        }
        cell.configure(with: sections[indexPath.section].matches[indexPath.row])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section < sections.count,
              let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderLeagueTableWrapper.reuseIdentifier) as? HeaderLeagueTableWrapper else {
            return nil
        }
        headerView.configure(with: sections[section].league)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 56 }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard indexPath.section < sections.count,
              indexPath.row < sections[indexPath.section].matches.count else { return }
        let match = sections[indexPath.section].matches[indexPath.row]
        let detailVC = EventDetailViewController(match: match)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
