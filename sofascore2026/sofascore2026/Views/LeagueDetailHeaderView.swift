import UIKit
import SnapKit
import SofaAcademic

final class LeagueDetailHeaderView: BaseView {

    private let backButton = UIButton()
    private let leagueImageView = UIImageView()
    private let leagueLabel = UILabel()

    var onBackTapped: (() -> Void)?

    override func addViews() {
        addSubview(backButton)
        addSubview(leagueImageView)
        addSubview(leagueLabel)
    }

    override func styleViews() {
        leagueImageView.contentMode = .scaleAspectFit

        leagueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        leagueLabel.textColor = .secondaryText
        leagueLabel.numberOfLines = 1
        leagueLabel.lineBreakMode = .byTruncatingTail

        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "icon")?.withRenderingMode(.alwaysTemplate)
        config.baseForegroundColor = .primaryText
        backButton.configuration = config
    }

    override func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
            $0.top.bottom.equalToSuperview().inset(12)
        }

        leagueImageView.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(28)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }

        leagueLabel.snp.makeConstraints {
            $0.leading.equalTo(leagueImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }

    override func setupGestureRecognizers() {
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    }

    func configure(with league: LeagueModel) {
        leagueLabel.text = "\(league.countryName), \(league.leagueName)"
        leagueImageView.loadImage(from: league.logoUrl)
    }

    @objc private func didTapBack() {
        onBackTapped?()
    }
}
