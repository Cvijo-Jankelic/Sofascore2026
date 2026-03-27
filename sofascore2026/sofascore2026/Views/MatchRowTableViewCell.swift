//
//  MatchRowTableView.swift
//  sofascore2026
//
//  Created by akademija on 22.03.2026..
//

import UIKit
import SnapKit

class MatchRowTableViewCell: UITableViewCell{
    static let reuseIdentifier = "MatchRowTableViewCell"

        private let matchRowView = MatchRowView()

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupView()
        }

        @available(*, unavailable)
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func configure(with model: MatchModel) {
            matchRowView.configure(with: model)
        }

        private func setupView() {
            selectionStyle = .none
            backgroundColor = .white
            contentView.backgroundColor = .white
            contentView.addSubview(matchRowView)

            matchRowView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
}
