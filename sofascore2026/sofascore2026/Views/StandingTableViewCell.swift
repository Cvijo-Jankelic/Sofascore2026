import UIKit
import SnapKit

final class StandingTableViewCell: UITableViewCell {
    static let reuseIdentifier = "StandingTableViewCell"

    private let standingRowCell = StandingRowCell()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(standingRowCell)
        standingRowCell.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    func configure(with model: StandingRowModel) {
        standingRowCell.configure(with: model)
    }
}
