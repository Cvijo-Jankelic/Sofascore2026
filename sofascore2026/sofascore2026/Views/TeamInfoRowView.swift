import UIKit
import SnapKit
import SofaAcademic

final class TeamInfoRowView: BaseView {

    private let titleLabel = UILabel()
    private let valueLabel = UILabel()
    private let separator = UIView()

    override func addViews() {
        addSubview(titleLabel)
        addSubview(valueLabel)
        addSubview(separator)
    }

    override func styleViews() {
        backgroundColor = .white

        titleLabel.font = .countryName
        titleLabel.textColor = .primaryText

        valueLabel.font = .leagueName
        valueLabel.textColor = .secondaryText
        valueLabel.textAlignment = .right
        valueLabel.numberOfLines = 1

        separator.backgroundColor = .separator
    }

    override func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }

        valueLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(8)
        }

        separator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }

    func configure(label: String, value: String) {
        titleLabel.text = label
        valueLabel.text = value
    }
}
