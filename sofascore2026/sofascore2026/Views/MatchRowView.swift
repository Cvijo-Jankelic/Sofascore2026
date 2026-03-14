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


    override func addViews() {
        addSubview(matchTimeLabel)
        addSubview(matchStatusLabel)
        addSubview(separatorView)
        addSubview(homeClubImageView)
        addSubview(awayClubImageView)
        addSubview(homeTeamNameLabel)
        addSubview(awayTeamNameLabel)
        addSubview(homeScoreLabel)
        addSubview(awayScoreLabel)
    }

    override func styleViews() {
        matchTimeLabel.font = .matchTime
        matchTimeLabel.textColor = .secondaryText
        matchTimeLabel.textAlignment = .center
        matchTimeLabel.numberOfLines = 1

        matchStatusLabel.font = .matchTime
        matchStatusLabel.textAlignment = .center
        matchStatusLabel.numberOfLines = 1

        separatorView.backgroundColor = .separator

        homeTeamNameLabel.font = .teamName
        homeTeamNameLabel.numberOfLines = 1

        awayTeamNameLabel.font = .teamName
        awayTeamNameLabel.numberOfLines = 1

        homeScoreLabel.font = .matchScore
        homeScoreLabel.textAlignment = .right

        awayScoreLabel.font = .matchScore
        awayScoreLabel.textAlignment = .right

        homeClubImageView.contentMode = .scaleAspectFit
        awayClubImageView.contentMode = .scaleAspectFit
    }

    override func setupConstraints() {
        matchTimeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(8)
            $0.width.equalTo(44)
        }

        matchStatusLabel.snp.makeConstraints {
            $0.top.equalTo(matchTimeLabel.snp.bottom).offset(2)
            $0.leading.width.equalTo(matchTimeLabel)
            $0.bottom.equalToSuperview().offset(-8)
        }

        separatorView.snp.makeConstraints {
            $0.leading.equalTo(matchTimeLabel.snp.trailing).offset(8)
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
        }

        awayTeamNameLabel.snp.makeConstraints {
            $0.leading.equalTo(awayClubImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(awayClubImageView)
            $0.bottom.equalToSuperview().offset(-8)
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

    func configure(with model: MatchModel) {
        matchTimeLabel.text = model.timeText
        matchStatusLabel.text = model.statusText
        matchStatusLabel.textColor = model.scoreColor

        homeTeamNameLabel.text = model.homeTeamName
        homeTeamNameLabel.textColor = model.homeTeamColor

        awayTeamNameLabel.text = model.awayTeamName
        awayTeamNameLabel.textColor = model.awayTeamColor

        homeScoreLabel.text = model.homeScore
        homeScoreLabel.textColor = model.scoreColor

        awayScoreLabel.text = model.awayScore
        awayScoreLabel.textColor = model.scoreColor

        homeClubImageView.loadImage(from: model.homeTeamLogoUrl)
        awayClubImageView.loadImage(from: model.awayTeamLogoUrl)
    }
} // UIImageView+Extensions.swift

extension UIImageView {
    func loadImage(from url: URL?) {
        guard let url = url else { return }
            
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
                
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}
