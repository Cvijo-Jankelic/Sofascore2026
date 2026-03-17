//
//  HeaderLeague.swift
//  sofascore2026
//
//  Created by akademija on 11.03.2026..
//

import SofaAcademic
import SnapKit
import UIKit

class HeaderLeagueView: BaseView {

    private let logoImageView = UIImageView()
    private let countryLabel = UILabel()
    private let arrowLabel = UILabel()
    private let leagueNameLabel = UILabel()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(countryLabel)
        addSubview(arrowLabel)
        addSubview(leagueNameLabel)
    }

    override func styleViews() {
        logoImageView.contentMode = .scaleAspectFit
        

        countryLabel.font = .countryName
        countryLabel.numberOfLines = 1

        arrowLabel.text = "▶"
        arrowLabel.font = .systemFont(ofSize: 10)
        arrowLabel.textColor = .secondaryText

        leagueNameLabel.font = .leagueName
        leagueNameLabel.textColor = .secondaryText
        leagueNameLabel.numberOfLines = 1
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(24)
            $0.width.height.equalTo(32)
            $0.top.equalToSuperview().offset(12)
            $0.bottom.equalToSuperview().offset(-12)
        }

        countryLabel.snp.makeConstraints {
            $0.leading.equalTo(logoImageView.snp.trailing).offset(26)
            $0.centerY.equalToSuperview()
        }

        arrowLabel.snp.makeConstraints {
            $0.leading.equalTo(countryLabel.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
        }

        leagueNameLabel.snp.makeConstraints {
            $0.leading.equalTo(arrowLabel.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
        }
    }

    func configure(with model: LeagueModel) {
        countryLabel.text = model.countryName
        leagueNameLabel.text = model.leagueName

        if let logoUrl = model.logoUrl {
            logoImageView.loadImage(from: URL(string: logoUrl))
        }
    }
}
