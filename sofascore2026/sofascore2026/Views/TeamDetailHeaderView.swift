import UIKit
import SnapKit
import SofaAcademic

final class TeamDetailHeaderView: BaseView {

    private let backButton = UIButton()
    private let teamImageView = UIImageView()
    private let teamNameLabel = UILabel()

    var onBackTapped: (() -> Void)?

    override func addViews() {
        addSubview(backButton)
        addSubview(teamImageView)
        addSubview(teamNameLabel)
    }

    override func styleViews() {
        teamImageView.contentMode = .scaleAspectFit

        teamNameLabel.font = .systemFont(ofSize: 14, weight: .regular)
        teamNameLabel.textColor = .secondaryText
        teamNameLabel.numberOfLines = 1
        teamNameLabel.lineBreakMode = .byTruncatingTail

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

        teamImageView.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(28)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }

        teamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(teamImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }

    override func setupGestureRecognizers() {
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    }

    func configure(teamName: String, teamLogoUrl: String?) {
        teamNameLabel.text = teamName
        teamImageView.loadImage(from: teamLogoUrl)
    }

    @objc private func didTapBack() {
        onBackTapped?()
    }
}
