import UIKit
import SnapKit

final class SettingsViewController: UIViewController {

    private let headerView = UIView()
    private let usernameLabel = UILabel()

    private let eventsLabel = UILabel()
    private let eventsCountLabel = UILabel()
    private let eventsSeparator = UIView()

    private let leaguesLabel = UILabel()
    private let leaguesCountLabel = UILabel()
    private let leaguesSeparator = UIView()

    private let logoutButton = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        addViews()
        styleViews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .white
        refreshStats()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.tintColor = nil
        let defaultAppearance = UINavigationBarAppearance()
        defaultAppearance.configureWithDefaultBackground()
        navigationController?.navigationBar.standardAppearance = defaultAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = defaultAppearance
    }

    private func addViews() {
        view.addSubview(headerView)
        headerView.addSubview(usernameLabel)
        view.addSubview(eventsLabel)
        view.addSubview(eventsCountLabel)
        view.addSubview(eventsSeparator)
        view.addSubview(leaguesLabel)
        view.addSubview(leaguesCountLabel)
        view.addSubview(leaguesSeparator)
        view.addSubview(logoutButton)
    }

    private func styleViews() {
        view.backgroundColor = .white

        headerView.backgroundColor = .sofaLightBlue

        usernameLabel.text = AuthService.shared.username ?? "User"
        usernameLabel.font = .systemFont(ofSize: 24, weight: .bold)
        usernameLabel.textColor = .white
        usernameLabel.textAlignment = .center

        eventsLabel.text = "Events"
        eventsLabel.font = .countryName
        eventsLabel.textColor = .primaryText

        eventsCountLabel.font = .countryName
        eventsCountLabel.textColor = .secondaryText
        eventsCountLabel.textAlignment = .right

        eventsSeparator.backgroundColor = .separator

        leaguesLabel.text = "Leagues"
        leaguesLabel.font = .countryName
        leaguesLabel.textColor = .primaryText

        leaguesCountLabel.font = .countryName
        leaguesCountLabel.textColor = .secondaryText
        leaguesCountLabel.textAlignment = .right

        leaguesSeparator.backgroundColor = .separator

        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.titleLabel?.font = .sportSelectorTitle
        logoutButton.backgroundColor = .sofaLightBlue
        logoutButton.layer.cornerRadius = 4
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(180)
        }

        usernameLabel.snp.makeConstraints {
            $0.centerX.equalTo(headerView)
            $0.centerY.equalTo(view.safeAreaLayoutGuide.snp.top).offset(90)
            $0.leading.trailing.equalTo(headerView).inset(16)
        }

        eventsLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().inset(16)
        }

        eventsCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(eventsLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.greaterThanOrEqualTo(eventsLabel.snp.trailing).offset(8)
        }

        eventsSeparator.snp.makeConstraints {
            $0.top.equalTo(eventsLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        leaguesLabel.snp.makeConstraints {
            $0.top.equalTo(eventsSeparator.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
        }

        leaguesCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(leaguesLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.leading.greaterThanOrEqualTo(leaguesLabel.snp.trailing).offset(8)
        }

        leaguesSeparator.snp.makeConstraints {
            $0.top.equalTo(leaguesLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }

        logoutButton.snp.makeConstraints {
            $0.top.equalTo(leaguesSeparator.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(48)
        }
    }

    private func refreshStats() {
        eventsCountLabel.text = "\(DatabaseManager.shared.eventCount())"
        leaguesCountLabel.text = "\(DatabaseManager.shared.leagueCount())"
    }

    @objc private func didTapLogout() {
        let alert = UIAlertController(
            title: "Logout",
            message: "Are you sure you want to logout?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive) { _ in
            AuthService.shared.logout()
            AppDelegate.showLogin()
        })
        present(alert, animated: true)
    }
}
