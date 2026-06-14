import UIKit
import SnapKit

final class LeagueDetailViewController: UIViewController {

    private let league: LeagueModel
    private let sport: Sport
    private let headerView = LeagueDetailHeaderView()
    private let leagueDetailView = LeagueDetailView()

    init(league: LeagueModel, sport: Sport) {
        self.league = league
        self.sport = sport
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleView()
        setupConstraints()
        configure()
        fetchData()
    }

    private func addViews() {
        view.addSubview(headerView)
        view.addSubview(leagueDetailView)
    }

    private func styleView() {
        view.backgroundColor = .white
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        leagueDetailView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configure() {
        headerView.configure(with: league)
        headerView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }

        leagueDetailView.onMatchTapped = { [weak self] match in
            let detailVC = EventDetailViewController(match: match)
            self?.navigationController?.pushViewController(detailVC, animated: true)
        }

        leagueDetailView.onTeamTapped = { [weak self] teamId, teamName, teamLogoUrl in
            let teamVC = TeamDetailViewController(teamId: teamId, teamName: teamName, teamLogoUrl: teamLogoUrl)
            self?.navigationController?.pushViewController(teamVC, animated: true)
        }
    }

    private func fetchData() {
        guard let token = AuthService.shared.token else { return }
        let leagueId = league.id

        Task {
            async let eventsTask = APIClient.shared.fetchLeagueEvents(leagueId: leagueId, sport: sport.slug, token: token)
            async let standingsTask = APIClient.shared.fetchStandings(leagueId: leagueId, token: token)

            do {
                let (apiEvents, apiStandings) = try await (eventsTask, standingsTask)
                let matchSections = makeMatchSections(from: apiEvents)
                let standingRows = makeStandingRows(from: apiStandings)
                leagueDetailView.matchesView.configure(with: matchSections)
                leagueDetailView.standingsView.configure(with: standingRows)
            } catch {
                showError("Failed to load league data. Please try again.")
            }
        }
    }

    private func makeMatchSections(from events: [APIEvent]) -> [(round: String, matches: [MatchModel])] {
        var roundsDict: [(key: String, matches: [MatchModel])] = []
        for event in events {
            let round = event.roundInfoText
            let match = event.toMatchModel(sport: sport, fallbackLeague: league)
            if let idx = roundsDict.firstIndex(where: { $0.key == round }) {
                roundsDict[idx].matches.append(match)
            } else {
                roundsDict.append((key: round, matches: [match]))
            }
        }
        return roundsDict.map { (round: $0.key, matches: $0.matches) }
    }

    private func makeStandingRows(from apiRows: [APIStandingRow]) -> [StandingRowModel] {
        apiRows.map {
            StandingRowModel(
                position: $0.position,
                teamId: $0.team.id,
                teamName: $0.team.name,
                teamLogoUrl: $0.team.logoUrl,
                played: $0.matches,
                wins: $0.wins,
                draws: $0.draws,
                losses: $0.losses,
                scoresFor: $0.scoreFor,
                scoresAgainst: $0.scoreAgainst,
                points: $0.points
            )
        }
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
