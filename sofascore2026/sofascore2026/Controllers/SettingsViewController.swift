import UIKit
import SnapKit

final class SettingsViewController: UIViewController {

    private let headerView = UIView()
    private let avatarView = UIView()
    private let avatarLabel = UILabel()
    private let usernameLabel = UILabel()
    private let userSubtitleLabel = UILabel()

    private let statsCard = UIView()
    private let statsTitleLabel = UILabel()
    private let eventStatRow = StatRowView()
    private let leagueStatRow = StatRowView()
    private let divider = UIView()

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
        refreshStats()
    }

    private func addViews() {
        view.addSubview(headerView)
        headerView.addSubview(avatarView)
        avatarView.addSubview(avatarLabel)
        headerView.addSubview(usernameLabel)
        headerView.addSubview(userSubtitleLabel)

        view.addSubview(statsCard)
        statsCard.addSubview(statsTitleLabel)
        statsCard.addSubview(eventStatRow)
        statsCard.addSubview(divider)
        statsCard.addSubview(leagueStatRow)

        view.addSubview(logoutButton)
    }

    private func styleViews() {
        view.backgroundColor = UIColor(red: 245/255, green: 246/255, blue: 250/255, alpha: 1)

        headerView.backgroundColor = .sofaLightBlue

        avatarView.backgroundColor = .white
        avatarView.layer.cornerRadius = 36
        avatarView.layer.shadowColor = UIColor.black.cgColor
        avatarView.layer.shadowOpacity = 0.15
        avatarView.layer.shadowRadius = 8
        avatarView.layer.shadowOffset = CGSize(width: 0, height: 4)

        avatarLabel.text = String(AuthService.shared.username?.prefix(1).uppercased() ?? "U")
        avatarLabel.font = .systemFont(ofSize: 32, weight: .bold)
        avatarLabel.textColor = .sofaLightBlue
        avatarLabel.textAlignment = .center

        usernameLabel.text = AuthService.shared.username ?? "User"
        usernameLabel.font = .systemFont(ofSize: 20, weight: .bold)
        usernameLabel.textColor = .white
        usernameLabel.textAlignment = .center

        userSubtitleLabel.text = "Sofascore Academy"
        userSubtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        userSubtitleLabel.textColor = UIColor.white.withAlphaComponent(0.75)
        userSubtitleLabel.textAlignment = .center

        statsCard.backgroundColor = .white
        statsCard.layer.cornerRadius = 16
        statsCard.layer.shadowColor = UIColor.black.cgColor
        statsCard.layer.shadowOpacity = 0.08
        statsCard.layer.shadowRadius = 12
        statsCard.layer.shadowOffset = CGSize(width: 0, height: 4)

        statsTitleLabel.text = "DATABASE"
        statsTitleLabel.font = .systemFont(ofSize: 11, weight: .semibold)
        statsTitleLabel.textColor = .secondaryText
        let attributed = NSAttributedString(
            string: "DATABASE",
            attributes: [.kern: 1.2]
        )
        statsTitleLabel.attributedText = attributed

        eventStatRow.configure(icon: "calendar", title: "Events", count: DatabaseManager.shared.eventCount())
        leagueStatRow.configure(icon: "trophy", title: "Leagues", count: DatabaseManager.shared.leagueCount())

        divider.backgroundColor = UIColor(red: 230/255, green: 232/255, blue: 236/255, alpha: 1)

        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        logoutButton.backgroundColor = .systemRed
        logoutButton.layer.cornerRadius = 12
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
    }

    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(240)
        }

        avatarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(28)
            $0.size.equalTo(72)
        }

        avatarLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        usernameLabel.snp.makeConstraints {
            $0.top.equalTo(avatarView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        userSubtitleLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        statsCard.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(-20)
            $0.leading.trailing.equalToSuperview().inset(24)
        }

        statsTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
        }

        eventStatRow.snp.makeConstraints {
            $0.top.equalTo(statsTitleLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }

        divider.snp.makeConstraints {
            $0.top.equalTo(eventStatRow.snp.bottom)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }

        leagueStatRow.snp.makeConstraints {
            $0.top.equalTo(divider.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview().inset(8)
        }

        logoutButton.snp.makeConstraints {
            $0.top.equalTo(statsCard.snp.bottom).offset(32)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(50)
        }
    }

    private func refreshStats() {
        eventStatRow.updateCount(DatabaseManager.shared.eventCount())
        leagueStatRow.updateCount(DatabaseManager.shared.leagueCount())
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

private final class StatRowView: UIView {

    private let iconContainer = UIView()
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let countLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconContainer)
        iconContainer.addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(countLabel)

        iconContainer.backgroundColor = UIColor.sofaLightBlue.withAlphaComponent(0.12)
        iconContainer.layer.cornerRadius = 10

        iconImageView.tintColor = .sofaLightBlue
        iconImageView.contentMode = .scaleAspectFit

        titleLabel.font = .systemFont(ofSize: 15, weight: .regular)
        titleLabel.textColor = .primaryText

        countLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        countLabel.textColor = .sofaLightBlue
        countLabel.textAlignment = .right

        iconContainer.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        }
        iconImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(18)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconContainer.snp.trailing).offset(14)
            $0.centerY.equalToSuperview()
        }
        countLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    func configure(icon: String, title: String, count: Int) {
        iconImageView.image = UIImage(systemName: icon)
        titleLabel.text = title
        countLabel.text = "\(count)"
    }

    func updateCount(_ count: Int) {
        countLabel.text = "\(count)"
    }
}
