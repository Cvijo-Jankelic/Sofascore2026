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
    
    private let timeStatusContainer = UIView()
    private let matchTimeLabel = UILabel()
    private let matchStatusLabel = UILabel()
    private let separatorView = UIView()
    private let homeClubImageView = UIImageView()
    private let awayClubImageView = UIImageView()
    private let homeTeamNameLabel = UILabel()
    private let awayTeamNameLabel = UILabel()
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    
    
    override func addViews() {
        
        addSubview(timeStatusContainer)
        timeStatusContainer.addSubview(matchTimeLabel)
        timeStatusContainer.addSubview(matchStatusLabel)
        
        addSubview(separatorView)
        addSubview(homeClubImageView)
        addSubview(awayClubImageView)
        addSubview(homeTeamNameLabel)
        addSubview(awayTeamNameLabel)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
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
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(64)
        }
        
        matchTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.height.equalTo(16)
        }

        matchStatusLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(4)
            $0.top.equalTo(matchTimeLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().inset(10)
            $0.height.equalTo(16)
        }
        
        separatorView.snp.makeConstraints {
            $0.leading.equalTo(timeStatusContainer.snp.trailing)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(1)
        }
        
        homeClubImageView.snp.makeConstraints {
            $0.leading.equalTo(separatorView.snp.trailing).offset(16)
            $0.top.equalToSuperview().inset(10)
            $0.size.equalTo(16)
        }
        
        awayClubImageView.snp.makeConstraints {
            $0.leading.equalTo(homeClubImageView)
            $0.bottom.equalToSuperview().inset(10)
            $0.size.equalTo(16)
        }
        
        homeTeamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(homeClubImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(homeClubImageView.snp.centerY)
            $0.trailing.lessThanOrEqualTo(homeScoreLabel.snp.leading).offset(-16)
            $0.height.equalTo(16)
        }
        
        awayTeamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(awayClubImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(awayClubImageView)
            $0.trailing.lessThanOrEqualTo(awayScoreLabel.snp.leading).offset(-16)
            $0.height.equalTo(16)
        }
        
        homeScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(homeTeamNameLabel)
            $0.width.equalTo(32)
            $0.height.equalTo(16)
        }
        
        awayScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(32)
            $0.height.equalTo(16)
            $0.centerY.equalTo(awayTeamNameLabel)
        }
    }
    
    func configure(with model: MatchModel) {
        matchTimeLabel.text = model.timeText
        matchStatusLabel.text = model.statusText
        homeTeamNameLabel.text = model.homeTeamName
        awayTeamNameLabel.text = model.awayTeamName
        homeScoreLabel.text = model.homeScore
        awayScoreLabel.text = model.awayScore
        
        applyColors(with: model)

                
        homeClubImageView.loadImage(from: model.homeTeamLogoUrl)
        awayClubImageView.loadImage(from: model.awayTeamLogoUrl)
    }
    
    private func applyColors(with model: MatchModel) {
        matchStatusLabel.textColor = model.statusColor
        homeScoreLabel.textColor = model.homeScoreColor
        awayScoreLabel.textColor = model.awayScoreColor
        homeTeamNameLabel.textColor = model.homeTeamColor
        awayTeamNameLabel.textColor = model.awayTeamColor
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
