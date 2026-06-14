import UIKit
import SnapKit

final class TeamDetailViewController: UIViewController {

    private let teamId: Int
    private let teamName: String
    private let teamLogoUrl: String?
    private let headerView = TeamDetailHeaderView()
    private let teamDetailView = TeamDetailView()

    init(teamId: Int, teamName: String, teamLogoUrl: String?) {
        self.teamId = teamId
        self.teamName = teamName
        self.teamLogoUrl = teamLogoUrl
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
        view.addSubview(teamDetailView)
    }

    private func styleView() {
        view.backgroundColor = .white
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }

        teamDetailView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    private func configure() {
        headerView.configure(teamName: teamName, teamLogoUrl: teamLogoUrl)
        headerView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }

    private func fetchData() {
        guard let token = AuthService.shared.token else { return }

        Task {
            async let teamTask = APIClient.shared.fetchTeam(teamId: teamId, token: token)
            async let playersTask = APIClient.shared.fetchPlayers(teamId: teamId, token: token)

            do {
                let (apiTeam, apiPlayers) = try await (teamTask, playersTask)
                let teamModel = makeTeamModel(from: apiTeam)
                let playerModels = makePlayers(from: apiPlayers)
                teamDetailView.infoView.configure(with: teamModel)
                teamDetailView.squadView.configure(with: playerModels)
            } catch {
                showError("Failed to load team data. Please try again.")
            }
        }
    }

    private func makeTeamModel(from api: APITeamDetails) -> TeamModel {
        TeamModel(
            id: api.team.id,
            name: api.team.name,
            logoUrl: api.team.logoUrl,
            country: api.team.country?.name,
            managerName: api.manager?.name,
            venue: api.venue?.name,
            totalPlayers: nil
        )
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    private func makePlayers(from apiPlayers: [APIPlayer]) -> [PlayerModel] {
        apiPlayers.map {
            PlayerModel(
                id: $0.id,
                name: $0.name,
                position: $0.position,
                jerseyNumber: $0.jerseyNumber.flatMap { Int($0) }
            )
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
