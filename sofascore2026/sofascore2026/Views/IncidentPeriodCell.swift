//
//  IncidentPeriodCell.swift
//  sofascore2026
//
//  Created by akademija on 5.06.2026..

import UIKit
import SnapKit
import SofaAcademic

final class IncidentPeriodCell: BaseView {

    private let backgroundShield = UIView()
    private let textLabel = UILabel()

    override func addViews() {
        addSubview(backgroundShield)
        backgroundShield.addSubview(textLabel)
    }

    override func styleViews() {
        backgroundColor = .white
        backgroundShield.backgroundColor = UIColor(red: 247/255, green: 246/255, blue: 239/255, alpha: 1)
        backgroundShield.layer.cornerRadius = 12

        textLabel.font = .incidentPeriod
        textLabel.textColor = .primaryText
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 1
    }

    override func setupConstraints() {
        backgroundShield.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.bottom.equalToSuperview().inset(8)
        }
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }

    func configure(with text: String) {
        textLabel.text = text
    }
}
