import UIKit
import SofaAcademic
import SnapKit

class HomeViewController: UIViewController {

    private let dataSource = Homework2DataSource()
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupStackView()
        configure()
    }

    private func setupView() {
        view.backgroundColor = .white
    }

    private func setupStackView() {
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 0

        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().offset(6)
        }
    }

    private func configure() {
        let league = dataSource.laLigaLeague()
        let leagueHeaderView = HeaderLeagueView()
        leagueHeaderView.configure(with: makeLeagueModel(from: league))
        stackView.addArrangedSubview(leagueHeaderView)

        let events = dataSource.laLigaEvents()
        events.forEach { event in
            let matchRowView = MatchRowView()
            matchRowView.configure(with: makeMatchModel(from: event))
            stackView.addArrangedSubview(matchRowView)
        }
    }

    private func makeLeagueModel(from league: League) -> LeagueModel {
        LeagueModel(
            countryName: league.country?.name ?? "",
            leagueName: league.name,
            logoUrl: league.logoUrl
        )
    }

    private func makeMatchModel(from event: Event) -> MatchModel {
        MatchModel(
            timeText: event.timeText,
            statusText: event.statusText,
            homeTeamName: event.homeTeam.name,
            awayTeamName: event.awayTeam.name,
            homeScore: event.homeScore.map { "\($0)" },
            awayScore: event.awayScore.map { "\($0)" },
            scoreColor: event.scoreColor,
            homeTeamColor: event.homeTeamColor,
            awayTeamColor: event.awayTeamColor,
            homeTeamLogoUrl: URL(string: event.homeTeam.logoUrl ?? ""),
            awayTeamLogoUrl: URL(string: event.awayTeam.logoUrl ?? "")
        )
    }
}
