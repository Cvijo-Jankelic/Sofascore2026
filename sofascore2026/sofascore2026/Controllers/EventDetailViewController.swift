import UIKit
import SnapKit
import SofaAcademic

final class EventDetailViewController: UIViewController {
    
    private let match: MatchModel
    private let eventDetailView = EventDetailView()
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func addViews() {
        view.addSubview(eventDetailView)
    }
    
    private func styleView() {
        view.backgroundColor = .white
        setupNavigationBar()
    }
    
    private func setupConstraints() {
        eventDetailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func configure() {
        eventDetailView.configure(with: match)
    }
    
    private func setupNavigationBar() {
        let containerView = UIView()
        
        let leagueImageView = UIImageView()
        leagueImageView.contentMode = .scaleAspectFit
        leagueImageView.loadImage(from: URL(string: match.league.logoUrl ?? ""))
        leagueImageView.snp.makeConstraints {
            $0.size.equalTo(16)
        }
        
        let leagueLabel = UILabel()
        leagueLabel.text = "\(match.sport.title), \(match.league.countryName), \(match.league.leagueName)"
        leagueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        leagueLabel.textColor = .secondaryText
        
        let titleStack = UIStackView(arrangedSubviews: [leagueImageView, leagueLabel])
        titleStack.axis = .horizontal
        titleStack.spacing = 8
        titleStack.alignment = .center
        
        containerView.addSubview(titleStack)
        titleStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let backButton = UIBarButtonItem(
            image: UIImage(named: "icon")?.withRenderingMode(.alwaysTemplate),
            style: .plain,
            target: self,
            action: #selector(backTapped)
        )
        navigationItem.leftBarButtonItem = backButton
        
        navigationItem.titleView = containerView
        navigationController?.navigationBar.tintColor = .primaryText
        navigationItem.backButtonDisplayMode = .minimal
        
        print("Back image loaded: \(UIImage(named: "icon") != nil)")
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}
