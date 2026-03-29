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
    
    private let homeGroupedView = UIView()
    private let awayGroupedView = UIView()
    private let scoreLabelView = UIView()
    
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
        
        homeGroupedView.addSubview(homeClubImageView)
        homeGroupedView.addSubview(homeTeamNameLabel)
        
        awayGroupedView.addSubview(awayClubImageView)
        awayGroupedView.addSubview(awayTeamNameLabel)
        
        addSubview(matchDateLabel)
        addSubview(matchStatusLabel)
        addSubview(matchTimeLabel)
        
        scoreLabelView.addSubview(homeScoreLabel)
        scoreLabelView.addSubview(awayScoreLabel)
        scoreLabelView.addSubview(separatorLabel)
    }
    
    
    override func styleViews(){
        setupMatchTimeLabel()
        setupMatchStatusLabel()
        setupTeamNameLabels()
        setupScoreLabels()
        setupImageViews()
        setupMatchDateLabel()
        
        separatorLabel.text = "-"
        separatorLabel.font = .eventDetailScore
        separatorLabel.textAlignment = .center

    }

    override func setupConstraints() {
        homeGroupedView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview().inset(16)
         //   $0.width.equalToSuperview().dividedBy(3)

        }
        
        awayGroupedView.snp.makeConstraints {
            $0.trailing.top.bottom.equalToSuperview().inset(16)
         //   $0.width.equalToSuperview().dividedBy(3)

        }
        
        matchDateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(24)
        }
        
        matchTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(44)
            $0.centerX.equalToSuperview()
        }
        
        matchStatusLabel.snp.makeConstraints {
            $0.leading.equalTo(homeGroupedView.snp.trailing)
            $0.trailing.equalTo(awayGroupedView.snp.leading)
            $0.top.equalToSuperview().inset(56)
        }
        
        scoreLabelView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
        }

        homeScoreLabel.snp.makeConstraints {
            $0.trailing.equalTo(separatorLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        separatorLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }

        awayScoreLabel.snp.makeConstraints {
            $0.leading.equalTo(separatorLabel.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        
        homeClubImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.top.centerX.equalToSuperview()
            $0.size.equalTo(40)
            
        }
        homeTeamNameLabel.snp.makeConstraints {
            $0.top.equalTo(homeClubImageView.snp.bottom).offset(8)
           // $0.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        awayClubImageView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.top.centerX.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        awayTeamNameLabel.snp.makeConstraints {
            $0.top.equalTo(awayClubImageView.snp.bottom).offset(8)
           // $0.leading.trailing.equalToSuperview()
            $0.centerX.equalToSuperview()
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
            separatorLabel.isHidden = true
            
            matchDateLabel.text = model.dateText
            matchTimeLabel.text = model.timeText
            
        case .inProgress, .halfTime:
            matchDateLabel.isHidden = true
            matchTimeLabel.isHidden = true
            scoreLabelView.isHidden = false
            matchStatusLabel.isHidden = false
            separatorLabel.isHidden = false
            
            homeScoreLabel.text = model.homeScore ?? "-"
            awayScoreLabel.text = model.awayScore ?? "-"
            homeScoreLabel.textColor = model.scoreColor
            awayScoreLabel.textColor = model.scoreColor
            separatorLabel.textColor = model.scoreColor
            matchStatusLabel.text = model.statusText
            matchStatusLabel.textColor = model.statusColor
            
        case .finished:
            matchDateLabel.isHidden = true
            matchTimeLabel.isHidden = true
            scoreLabelView.isHidden = false
            matchStatusLabel.isHidden = false
            separatorLabel.isHidden = false
            
            homeScoreLabel.text = model.homeScore ?? "-"
            awayScoreLabel.text = model.awayScore ?? "-"
            homeScoreLabel.textColor = model.scoreColor
            awayScoreLabel.textColor = model.scoreColor
            separatorLabel.textColor = model.scoreColor
            matchStatusLabel.text = "Full Time"
            matchStatusLabel.textColor = model.statusColor
        }
        
        setImage(for: homeClubImageView, urlString: model.homeTeamLogoUrl)
        setImage(for: awayClubImageView, urlString: model.awayTeamLogoUrl)
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
            $0.numberOfLines = 1
            $0.lineBreakMode = .byTruncatingTail
            $0.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
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
    
    func setImage(for imageView: UIImageView, urlString: String?) {
        imageView.loadImage(from: URL(string: urlString ?? ""))
    }
}
