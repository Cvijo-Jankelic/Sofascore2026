
import UIKit
import SnapKit

final class EventDetailViewController: UIViewController {
    
    private let match: MatchModel
    private let headerView = EventDetailHeaderView()
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
    
    private func addViews() {
        view.addSubview(headerView)
        view.addSubview(eventDetailView)
    }
    
    private func styleView() {
        view.backgroundColor = .white
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        eventDetailView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func configure() {
        headerView.configure(with: match)
        headerView.onBackTapped = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        eventDetailView.configure(with: match)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
