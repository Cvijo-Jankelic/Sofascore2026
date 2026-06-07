import UIKit
import SnapKit
import SofaAcademic

final class PlayerRowCell: BaseView {

    private let jerseyLabel = UILabel()
    private let nameLabel = UILabel()
    private let positionLabel = UILabel()
    private let separator = UIView()

    override func addViews() {
        addSubview(jerseyLabel)
        addSubview(nameLabel)
        addSubview(positionLabel)
        addSubview(separator)
    }

    override func styleViews() {
        backgroundColor = .white

        jerseyLabel.font = .matchScore
        jerseyLabel.textColor = .secondaryText
        jerseyLabel.textAlignment = .center
        jerseyLabel.numberOfLines = 1

        nameLabel.font = .teamName
        nameLabel.textColor = .primaryText
        nameLabel.numberOfLines = 1

        positionLabel.font = .matchTime
        positionLabel.textColor = .secondaryText
        positionLabel.textAlignment = .right
        positionLabel.numberOfLines = 1

        separator.backgroundColor = .separator
    }

    override func setupConstraints() {
        jerseyLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(28)
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(jerseyLabel.snp.trailing).offset(12)
            $0.centerY.equalToSuperview()
        }

        positionLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).offset(8)
        }

        separator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    func configure(with model: PlayerModel) {
        jerseyLabel.text = model.jerseyNumber.map { "\($0)" } ?? "-"
        nameLabel.text = model.name
        positionLabel.text = model.position ?? ""
    }
}
