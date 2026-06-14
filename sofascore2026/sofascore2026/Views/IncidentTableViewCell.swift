//
//  IncidentTableViewCell.swift
//  sofascore2026
//
//  Created by akademija on 5.06.2026..

import UIKit
import SnapKit

final class IncidentTableViewCell: UITableViewCell {
    static let reuseIdentifier = "IncidentTableViewCell"

    private let incidentCell = IncidentCell()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.addSubview(incidentCell)
        incidentCell.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) { fatalError() }

    func configure(with model: IncidentModel) {
        incidentCell.configure(with: model)
    }
}
