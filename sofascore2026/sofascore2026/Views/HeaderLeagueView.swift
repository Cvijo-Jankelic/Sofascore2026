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
    private let ligaInfoContainer = UIView()
    private let countryLabel = UILabel()
    private let arrowLabel = UILabel()
    private let leagueNameLabel = UILabel()

    override func addViews() {
        addSubview(logoImageView)
        addSubview(ligaInfoContainer)
    
        ligaInfoContainer.addSubview(countryLabel)
        ligaInfoContainer.addSubview(arrowLabel)
        ligaInfoContainer.addSubview(leagueNameLabel)
    }

    override func styleViews() {
        logoImageView.contentMode = .scaleAspectFit
        

        countryLabel.font = .countryName
        countryLabel.numberOfLines = 1
        countryLabel.lineBreakMode = .byClipping
        countryLabel.textAlignment = .left

        countryLabel.setContentHuggingPriority(.required, for: .horizontal)
        countryLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        arrowLabel.text = "▶"
        arrowLabel.textAlignment = .center
        arrowLabel.font = .systemFont(ofSize: 10)
        arrowLabel.textColor = .secondaryText

        leagueNameLabel.font = .leagueName
        leagueNameLabel.textColor = .secondaryText
        leagueNameLabel.numberOfLines = 1
        leagueNameLabel.textAlignment = .left
    }

    override func setupConstraints() {
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.size.equalTo(32)
        }
        
        ligaInfoContainer.snp.makeConstraints{
            $0.leading.equalTo(logoImageView.snp.trailing).offset(32)
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
            $0.centerY.equalTo(logoImageView)
            $0.height.equalTo(24)
        }

        countryLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(16)
        }

        arrowLabel.snp.makeConstraints {
            $0.leading.equalTo(countryLabel.snp.trailing).offset(6)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        leagueNameLabel.snp.makeConstraints {
            $0.leading.equalTo(arrowLabel.snp.trailing).offset(6)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalTo(16)
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
