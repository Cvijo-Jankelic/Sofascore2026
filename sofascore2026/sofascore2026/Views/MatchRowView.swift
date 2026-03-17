//
//  MatchRowView.swift
//  sofascore2026
//
//  Created by akademija on 11.03.2026..
//

import UIKit
import SofaAcademic
import SnapKit

class MatchRowView: BaseView {
    
    
    private let matchTimeLabel = UILabel()
    private let matchStatusLabel = UILabel()
    private let separatorView = UIView()
    private let homeClubImageView = UIImageView()
    private let awayClubImageView = UIImageView()
    private let homeTeamNameLabel = UILabel()
    private let awayTeamNameLabel = UILabel()
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    
    private let timeStatusContainer = UIView()

    
    
    override func addViews() {
        timeStatusContainer.addSubview(matchTimeLabel)
        timeStatusContainer.addSubview(matchStatusLabel)
        
        addSubview(separatorView)
        addSubview(homeClubImageView)
        addSubview(awayClubImageView)
        addSubview(homeTeamNameLabel)
        addSubview(awayTeamNameLabel)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
        addSubview(timeStatusContainer)
    }
    
    override func styleViews() {
        setupMatchTimeLabel()
        setupMatchStatusLabel()
        setupTeamNameLabels()
        setupScoreLabels()
        setupImageViews()
        
        separatorView.backgroundColor = .separator

    }
    
    override func setupConstraints() {
        
        timeStatusContainer.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.top.equalToSuperview().offset(8)
            $0.width.equalTo(64)
            $0.height.equalTo(56)
        }
        
        matchTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }

        matchStatusLabel.snp.makeConstraints {
            $0.top.equalTo(matchTimeLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(timeStatusContainer.snp.trailing).offset(8)
            $0.top.equalToSuperview().offset(4)
            $0.bottom.equalToSuperview().offset(-4)
            $0.width.equalTo(1)
        }
        
        homeClubImageView.snp.makeConstraints {
            $0.leading.equalTo(separatorView.snp.trailing).offset(12)
            $0.top.equalToSuperview().offset(8)
            $0.width.height.equalTo(20)
        }
        
        awayClubImageView.snp.makeConstraints {
            $0.leading.equalTo(homeClubImageView)
            $0.top.equalTo(homeClubImageView.snp.bottom).offset(8)
            $0.width.height.equalTo(20)
        }
        
        homeTeamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(homeClubImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(homeClubImageView)
            $0.trailing.lessThanOrEqualTo(homeScoreLabel.snp.leading).offset(-16)
        }
        
        awayTeamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(awayClubImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(awayClubImageView)
            $0.bottom.equalToSuperview().offset(-8)
            $0.trailing.lessThanOrEqualTo(awayScoreLabel.snp.leading).offset(-16)
        }
        
        homeScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-32)
            $0.centerY.equalTo(homeTeamNameLabel)
        }
        
        awayScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-32)
            $0.centerY.equalTo(awayTeamNameLabel)
        }
    }
    
    func configure(with model: MatchModel, event: Event) {
        matchTimeLabel.text = model.timeText
        matchStatusLabel.text = model.statusText
        homeTeamNameLabel.text = model.homeTeamName
        awayTeamNameLabel.text = model.awayTeamName
        homeScoreLabel.text = model.homeScore
        awayScoreLabel.text = model.awayScore
        
        matchStatusLabel.textColor = MatchViewHelper.scoreColor(for: event)
        homeScoreLabel.textColor = MatchViewHelper.scoreColor(for: event)
        awayScoreLabel.textColor = MatchViewHelper.scoreColor(for: event)
        homeTeamNameLabel.textColor = MatchViewHelper.teamColor(for: event, side: .home)
        awayTeamNameLabel.textColor = MatchViewHelper.teamColor(for: event, side: .away)

        
        homeClubImageView.loadImage(from: model.homeTeamLogoUrl)
        awayClubImageView.loadImage(from: model.awayTeamLogoUrl)
    }
    
    private func setupMatchTimeLabel() {
        matchTimeLabel.font = .matchTime
        matchTimeLabel.textColor = .secondaryText
        matchTimeLabel.textAlignment = .center
        matchTimeLabel.numberOfLines = 1
    }

    private func setupMatchStatusLabel() {
        matchStatusLabel.font = .matchTime
        matchStatusLabel.textAlignment = .center
        matchStatusLabel.numberOfLines = 1
    }

    private func setupTeamNameLabels() {
        [homeTeamNameLabel, awayTeamNameLabel].forEach {
            $0.font = .teamName
            $0.numberOfLines = 1
            $0.lineBreakMode = .byTruncatingTail
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        }
    }

    private func setupScoreLabels() {
        [homeScoreLabel, awayScoreLabel].forEach {
            $0.font = .matchScore
            $0.textAlignment = .right
            $0.setContentHuggingPriority(.required, for: .horizontal)
            $0.setContentCompressionResistancePriority(.required, for: .horizontal)
        }
    }

    private func setupImageViews() {
        homeClubImageView.contentMode = .scaleAspectFit
        awayClubImageView.contentMode = .scaleAspectFit
    }
    
}
