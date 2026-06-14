import UIKit
import SnapKit

final class PlayerTableViewCell: UITableViewCell {
    static let reuseIdentifier = "PlayerTableViewCell"

    private let playerRowCell = PlayerRowCell()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(playerRowCell)
        playerRowCell.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    func configure(with model: PlayerModel) {
        playerRowCell.configure(with: model)
    }
}
