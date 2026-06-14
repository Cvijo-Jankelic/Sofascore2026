import UIKit
import SnapKit
import SofaAcademic

final class StandingRowCell: BaseView {

    private let positionLabel = UILabel()
    private let teamImageView = UIImageView()
    private let teamNameLabel = UILabel()
    private let playedLabel = UILabel()
    private let winsLabel = UILabel()
    private let drawsLabel = UILabel()
    private let lossesLabel = UILabel()
    private let pointsLabel = UILabel()
    override func addViews() {
        addSubview(positionLabel)
        addSubview(teamImageView)
        addSubview(teamNameLabel)
        addSubview(playedLabel)
        addSubview(winsLabel)
        addSubview(drawsLabel)
        addSubview(lossesLabel)
        addSubview(pointsLabel)
    }

    override func styleViews() {
        backgroundColor = .white

        positionLabel.font = .standingSecondary
        positionLabel.textColor = .secondaryText
        positionLabel.textAlignment = .center

        teamImageView.contentMode = .scaleAspectFit

        teamNameLabel.font = .standingTeamName
        teamNameLabel.textColor = .primaryText
        teamNameLabel.numberOfLines = 1
        teamNameLabel.lineBreakMode = .byTruncatingTail

        [playedLabel, winsLabel, drawsLabel, lossesLabel].forEach {
            $0.font = .standingSecondary
            $0.textColor = .secondaryText
            $0.textAlignment = .center
        }

        pointsLabel.font = .standingPoints
        pointsLabel.textColor = .primaryText
        pointsLabel.textAlignment = .center

    }

    override func setupConstraints() {

        positionLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        teamImageView.snp.makeConstraints {
            $0.leading.equalTo(positionLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }

        pointsLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        lossesLabel.snp.makeConstraints {
            $0.trailing.equalTo(pointsLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        drawsLabel.snp.makeConstraints {
            $0.trailing.equalTo(lossesLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        winsLabel.snp.makeConstraints {
            $0.trailing.equalTo(drawsLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        playedLabel.snp.makeConstraints {
            $0.trailing.equalTo(winsLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        teamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(teamImageView.snp.trailing).offset(8)
            $0.trailing.lessThanOrEqualTo(playedLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
        }

    }

    func configure(with model: StandingRowModel) {
        positionLabel.text = "\(model.position)"
        teamNameLabel.text = model.teamName
        playedLabel.text = "\(model.played)"
        winsLabel.text = "\(model.wins)"
        drawsLabel.text = "\(model.draws)"
        lossesLabel.text = "\(model.losses)"
        pointsLabel.text = "\(model.points)"
        teamImageView.loadImage(from: model.teamLogoUrl)
    }
}
