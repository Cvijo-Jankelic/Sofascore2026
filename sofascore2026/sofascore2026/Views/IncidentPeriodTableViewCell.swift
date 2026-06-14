//
//  IncidentPeriodTableViewCell.swift
//  sofascore2026
//
//  Created by akademija on 5.06.2026..

import UIKit
import SnapKit

final class IncidentPeriodTableViewCell: UITableViewCell {
    static let reuseIdentifier = "IncidentPeriodTableViewCell"

    private let periodCell = IncidentPeriodCell()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(periodCell)
        periodCell.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    func configure(with text: String) {
        periodCell.configure(with: text)
    }
}
