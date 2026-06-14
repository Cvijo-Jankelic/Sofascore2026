//
//  EventDetailView.swift
//  sofascore2026
//
//  Created by akademija on 28.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

final class EventDetailView: BaseView {

    var onHomeTeamTapped: (() -> Void)?
    var onAwayTeamTapped: (() -> Void)?

    private let homeGroupedView = UIStackView()
    private let awayGroupedView = UIStackView()
    private let scoreLabelView = UIStackView()
    
    private let matchDateLabel = UILabel()
    private let matchStatusLabel = UILabel()
    private let matchTimeLabel = UILabel()
    private let homeScoreLabel = UILabel()
    private let awayScoreLabel = UILabel()
    private let separatorLabel = UILabel()
    
    private let homeClubImageView = UIImageView()
    private let awayClubImageView = UIImageView()
    private let homeTeamNameLabel = UILabel()
    private let awayTeamNameLabel = UILabel()
    
    
    
    override func addViews(){
        addSubview(homeGroupedView)
        addSubview(awayGroupedView)
        addSubview(scoreLabelView)
        
        homeGroupedView.addArrangedSubview(homeClubImageView)
        homeGroupedView.addArrangedSubview(homeTeamNameLabel)

        awayGroupedView.addArrangedSubview(awayClubImageView)
        awayGroupedView.addArrangedSubview(awayTeamNameLabel)
        
        scoreLabelView.addArrangedSubview(homeScoreLabel)
        scoreLabelView.addArrangedSubview(separatorLabel)
        scoreLabelView.addArrangedSubview(awayScoreLabel)
        
        addSubview(matchDateLabel)
        addSubview(matchStatusLabel)
        addSubview(matchTimeLabel)
        
    }
    
    
    override func styleViews() {
        
        scoreLabelView.axis = .horizontal
        scoreLabelView.alignment = .center
        scoreLabelView.spacing = 8
        
        homeGroupedView.axis = .vertical
        homeGroupedView.alignment = .center
        homeGroupedView.spacing = 8
        
        awayGroupedView.axis = .vertical
        awayGroupedView.alignment = .center
        awayGroupedView.spacing = 8
        
        separatorLabel.text = "-"
        separatorLabel.font = .eventDetailScore
        separatorLabel.textAlignment = .center
        
        setupMatchTimeLabel()
        setupMatchStatusLabel()
        setupTeamNameLabels()
        setupScoreLabels()
        setupImageViews()
        setupMatchDateLabel()
    }

    override func setupConstraints() {
        homeGroupedView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.width.equalToSuperview().dividedBy(3).priority(.high)
        }

        awayGroupedView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.width.equalToSuperview().dividedBy(3).priority(.high)
        }
        
        scoreLabelView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
        }
        
        homeClubImageView.snp.makeConstraints {
            $0.size.equalTo(40)
        }

        
        awayClubImageView.snp.makeConstraints {
            $0.size.equalTo(40)
        }
        
        homeTeamNameLabel.snp.makeConstraints {
            $0.width.lessThanOrEqualToSuperview()
        }

        awayTeamNameLabel.snp.makeConstraints {
            $0.width.lessThanOrEqualToSuperview()
        }
        
        matchDateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(24)
            $0.leading.greaterThanOrEqualTo(homeGroupedView.snp.trailing).offset(4).priority(.high)
            $0.trailing.lessThanOrEqualTo(awayGroupedView.snp.leading).offset(-4).priority(.high)
        }

        matchTimeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(matchDateLabel.snp.bottom).offset(4)
            $0.leading.greaterThanOrEqualTo(homeGroupedView.snp.trailing).offset(4).priority(.high)
            $0.trailing.lessThanOrEqualTo(awayGroupedView.snp.leading).offset(-4).priority(.high)
        }

        matchStatusLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreLabelView.snp.bottom).offset(4)
            $0.leading.greaterThanOrEqualTo(homeGroupedView.snp.trailing).offset(4).priority(.high)
            $0.trailing.lessThanOrEqualTo(awayGroupedView.snp.leading).offset(-4).priority(.high)
        }
    }
    
    func configure(with model: MatchModel) {
        homeTeamNameLabel.text = model.homeTeamName
        awayTeamNameLabel.text = model.awayTeamName
        
        switch model.status {
        case .notStarted:
            matchDateLabel.isHidden = false
            matchTimeLabel.isHidden = false
            scoreLabelView.isHidden = true
            matchStatusLabel.isHidden = true
            
            matchDateLabel.text = model.dateText
            matchTimeLabel.text = model.timeText
            
        case .inProgress, .halfTime:
            matchDateLabel.isHidden = true
            matchTimeLabel.isHidden = true
            scoreLabelView.isHidden = false
            matchStatusLabel.isHidden = false
            
            homeScoreLabel.text = model.homeScore ?? "-"
            awayScoreLabel.text = model.awayScore ?? "-"
            matchStatusLabel.text = model.statusText
            
        case .finished:
            matchDateLabel.isHidden = true
            matchTimeLabel.isHidden = true
            scoreLabelView.isHidden = false
            matchStatusLabel.isHidden = false
            
            homeScoreLabel.text = model.homeScore ?? "-"
            awayScoreLabel.text = model.awayScore ?? "-"
            matchStatusLabel.text = "Full Time"
        }
        
        homeClubImageView.loadImage(from: model.homeTeamLogoUrl)
        awayClubImageView.loadImage(from: model.awayTeamLogoUrl)
        applyColors(with: model)
    }
    
    private func applyColors(with model: MatchModel) {
        matchStatusLabel.textColor = model.statusColor
        homeScoreLabel.textColor = model.homeScoreColor
        awayScoreLabel.textColor = model.awayScoreColor
        separatorLabel.textColor = model.statusColor
        homeTeamNameLabel.textColor = .primaryText  
        awayTeamNameLabel.textColor = .primaryText
    }
    
    private func setupMatchTimeLabel() {
        matchTimeLabel.font = .matchTime
        matchTimeLabel.textColor = .primaryText
        matchTimeLabel.textAlignment = .center
        matchTimeLabel.numberOfLines = 1
    }

    private func setupMatchStatusLabel() {
        matchStatusLabel.font = .eventDetailMicro
        matchStatusLabel.textAlignment = .center
        matchStatusLabel.numberOfLines = 1
    }
    
    private func setupMatchDateLabel() {
        matchDateLabel.font = .eventDetailMicro
    }

    private func setupTeamNameLabels() {
        [homeTeamNameLabel, awayTeamNameLabel].forEach {
            $0.font = .eventDetailTeamName
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.lineBreakMode = .byWordWrapping
        }
    }

    private func setupScoreLabels() {
        [homeScoreLabel, awayScoreLabel].forEach {
            $0.font = .eventDetailScore
            $0.textAlignment = .center

        }
    }

    private func setupImageViews() {
        homeClubImageView.contentMode = .scaleAspectFit
        awayClubImageView.contentMode = .scaleAspectFit
    }

    override func setupGestureRecognizers() {
        let homeTap = UITapGestureRecognizer(target: self, action: #selector(didTapHomeTeam))
        homeGroupedView.addGestureRecognizer(homeTap)
        homeGroupedView.isUserInteractionEnabled = true

        let awayTap = UITapGestureRecognizer(target: self, action: #selector(didTapAwayTeam))
        awayGroupedView.addGestureRecognizer(awayTap)
        awayGroupedView.isUserInteractionEnabled = true
    }

    @objc private func didTapHomeTeam() {
        onHomeTeamTapped?()
    }

    @objc private func didTapAwayTeam() {
        onAwayTeamTapped?()
    }
}
