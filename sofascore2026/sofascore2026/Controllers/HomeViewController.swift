import UIKit
import SofaAcademic
import SnapKit

class HomeViewController: UIViewController {
    private let footballDataSource = Homework3DataSource()
    private let sportSelectorView = SportSelectorView()
    private let tableView = UITableView(frame: .zero, style: .plain)

    private var selectedSport: Sport = .football {
        didSet {
            reloadContent()
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
    
    private func addViews(){
        view.addSubview(sportSelectorView)
        view.addSubview(tableView)
    }
    
    private func styleView(){
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
    
    private func setupConstraints(){
        sportSelectorView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.snp.makeConstraints{
            $0.top.equalTo(sportSelectorView.snp.bottom)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configure(){
        reloadContent()
    }
    
    private func reloadContent() {
        sportSelectorView.updateSelection(to: selectedSport)
        sections = makeSections(for: selectedSport)
        tableView.reloadData()
    }

    
    private func makeSections(for sport: Sport) -> [LeagueSectionModel] {
        switch sport {
        case .football:
            return makeFootballSections()
        case .basketball, .americanFootball:
            return []
        }
    }
    
    private func makeFootballSections() -> [LeagueSectionModel] {
        let events = footballDataSource.events()
        var orderedSections: [LeagueSectionModel] = []
        events.forEach { event in
            guard let league = event.league else { return } // unwrap League?
            
            let leagueId = league.id
            if let index = orderedSections.firstIndex(where: { $0.id == leagueId }) {
                let matchModel = makeMatchModel(from: event)
                orderedSections[index].matches.append(matchModel)
            } else {
                let section = LeagueSectionModel(
                    id: leagueId,
                    league: makeLeagueModel(from: league), // prosljeđuj unwrappani league
                    matches: [makeMatchModel(from: event)]
                )
                orderedSections.append(section)
            }
        }
        
        return orderedSections
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
            homeTeamLogoUrl: event.homeTeam.logoUrl,
            awayTeamLogoUrl: event.awayTeam.logoUrl,
            status: {
                switch event.status {
                case .notStarted:
                    return .notStarted
                case .inProgress, .halftime:
                    return .inProgress
                case .finished:
                    return .finished
                }
            }()
        )
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].matches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MatchRowTableViewCell.reuseIdentifier, for: indexPath) as? MatchRowTableViewCell else {
            return UITableViewCell()
        }

        let model = sections[indexPath.section].matches[indexPath.row]
        cell.configure(with: model)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderLeagueTableWrapper.reuseIdentifier) as? HeaderLeagueTableWrapper else {
            return nil
        }
        
        headerView.configure(with: sections[section].league)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        56
    }
}
