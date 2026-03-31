//
//  EventDetailHeaderView.swift
//  sofascore2026
//
//  Created by akademija on 31.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

final class EventDetailHeaderView: BaseView {
    
    private let leagueImageView = UIImageView()
    private let leagueLabel = UILabel()
    private let backButton = UIButton()
    
    var onBackTapped: (() -> Void)?
    
    override func addViews() {
        addSubview(backButton)
        addSubview(leagueImageView)
        addSubview(leagueLabel)
    }
    
    override func styleViews() {
        leagueLabel.numberOfLines = 1
        leagueLabel.lineBreakMode = .byTruncatingTail
        
        leagueImageView.contentMode = .scaleAspectFit
        leagueLabel.font = .systemFont(ofSize: 14, weight: .regular)
        leagueLabel.textColor = .secondaryText
        
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "icon")?.withRenderingMode(.alwaysTemplate)
        config.baseForegroundColor = .primaryText
        backButton.configuration = config
    }
    
    override func setupConstraints() {
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        leagueImageView.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(28)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        leagueLabel.snp.makeConstraints {
            $0.leading.equalTo(leagueImageView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview().inset(16)
        }
    }
    
    override func setupGestureRecognizers() {
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
    }
    
    func configure(with model: MatchModel) {
        leagueLabel.text = "\(model.sport.title), \(model.league.countryName), \(model.league.leagueName)"
        leagueImageView.loadImage(from: model.league.logoUrl)
    }
    
    @objc private func didTapBack() {
        onBackTapped?()
    }
}
