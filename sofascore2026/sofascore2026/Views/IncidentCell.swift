//
//  IncidentCell.swift
//  sofascore2026
//
//  Created by akademija on 5.06.2026..

import UIKit
import SnapKit
import SofaAcademic

final class IncidentCell: BaseView {

    private let iconImageView = UIImageView()
    private let minuteLabel = UILabel()
    private let divider = UIView()
    private let scoreLabel = UILabel()
    private let primaryLabel = UILabel()
    private let secondaryLabel = UILabel()

    override func addViews() {
        addSubview(iconImageView)
        addSubview(minuteLabel)
        addSubview(divider)
        addSubview(scoreLabel)
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
    }

    override func styleViews() {
        backgroundColor = .white

        iconImageView.contentMode = .scaleAspectFit

        minuteLabel.font = .incidentSecondary
        minuteLabel.textColor = .secondaryText
        minuteLabel.textAlignment = .center

        divider.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.1)

        scoreLabel.font = .incidentScore
        scoreLabel.textColor = .primaryText
        scoreLabel.numberOfLines = 1

        primaryLabel.font = .incidentPrimary
        primaryLabel.textColor = .primaryText
        primaryLabel.numberOfLines = 1

        secondaryLabel.font = .incidentSecondary
        secondaryLabel.textColor = .secondaryText
        secondaryLabel.numberOfLines = 1
    }

    override func setupConstraints() {
        applyHomeLayout(isGoal: false)
    }

    // MARK: - Configure

    func configure(with model: IncidentModel) {
        switch model.type {
        case let .goalHome(playerName, homeScore, awayScore, minute, scoreDiff):
            iconImageView.image = goalIcon(for: model.sport, scoreDiff: scoreDiff)
            minuteLabel.text = "\(minute)′"
            scoreLabel.text = "\(homeScore) - \(awayScore)"
            primaryLabel.text = playerName
            secondaryLabel.text = nil
            applyHomeLayout(isGoal: true)

        case let .goalAway(playerName, homeScore, awayScore, minute, scoreDiff):
            iconImageView.image = goalIcon(for: model.sport, scoreDiff: scoreDiff)
            minuteLabel.text = "\(minute)′"
            scoreLabel.text = "\(homeScore) - \(awayScore)"
            primaryLabel.text = playerName
            secondaryLabel.text = nil
            applyAwayLayout(isGoal: true)

        case let .yellowCardHome(playerName, minute, description):
            iconImageView.image = UIImage(named: "yellow_card")
            minuteLabel.text = "\(minute)′"
            primaryLabel.text = playerName
            secondaryLabel.text = description
            applyHomeLayout(isGoal: false)

        case let .yellowCardAway(playerName, minute, description):
            iconImageView.image = UIImage(named: "yellow_card")
            minuteLabel.text = "\(minute)′"
            primaryLabel.text = playerName
            secondaryLabel.text = description
            applyAwayLayout(isGoal: false)

        case let .redCardHome(playerName, minute, description):
            iconImageView.image = UIImage(systemName: "rectangle.fill")?.withTintColor(.liveRed, renderingMode: .alwaysOriginal)
            minuteLabel.text = "\(minute)′"
            primaryLabel.text = playerName
            secondaryLabel.text = description
            applyHomeLayout(isGoal: false)

        case let .redCardAway(playerName, minute, description):
            iconImageView.image = UIImage(systemName: "rectangle.fill")?.withTintColor(.liveRed, renderingMode: .alwaysOriginal)
            minuteLabel.text = "\(minute)′"
            primaryLabel.text = playerName
            secondaryLabel.text = description
            applyAwayLayout(isGoal: false)

        case let .defaultHome(playerName, description, minute):
            iconImageView.image = defaultIcon(for: model.sport)
            minuteLabel.text = "\(minute)′"
            primaryLabel.text = playerName
            secondaryLabel.text = description
            applyHomeLayout(isGoal: false)

        case let .defaultAway(playerName, description, minute):
            iconImageView.image = defaultIcon(for: model.sport)
            minuteLabel.text = "\(minute)′"
            primaryLabel.text = playerName
            secondaryLabel.text = description
            applyAwayLayout(isGoal: false)

        case .period:
            break
        }
    }

    // MARK: - Layout

    private func applyHomeLayout(isGoal: Bool) {
        iconImageView.snp.remakeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(8)
            $0.size.equalTo(24)
        }
        minuteLabel.snp.remakeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(40)
            $0.height.equalTo(16)
        }
        divider.snp.remakeConstraints {
            $0.leading.equalToSuperview().inset(55)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(1)
        }

        if isGoal {
            scoreLabel.isHidden = false
            secondaryLabel.isHidden = true

            scoreLabel.textAlignment = .left
            scoreLabel.snp.remakeConstraints {
                $0.leading.equalTo(divider.snp.trailing).offset(8)
                $0.centerY.equalToSuperview()
            }
            primaryLabel.textAlignment = .left
            primaryLabel.snp.remakeConstraints {
                $0.leading.equalTo(scoreLabel.snp.trailing).offset(8)
                $0.trailing.lessThanOrEqualToSuperview().inset(16)
                $0.centerY.equalToSuperview()
            }
            secondaryLabel.snp.remakeConstraints {
                $0.leading.equalTo(divider.snp.trailing).offset(8)
                $0.centerY.equalToSuperview()
                $0.width.equalTo(0)
            }
        } else {
            scoreLabel.isHidden = true
            secondaryLabel.isHidden = false

            primaryLabel.textAlignment = .left
            primaryLabel.snp.remakeConstraints {
                $0.leading.equalTo(divider.snp.trailing).offset(12)
                $0.top.equalToSuperview().inset(12)
                $0.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            secondaryLabel.textAlignment = .left
            secondaryLabel.snp.remakeConstraints {
                $0.leading.equalTo(divider.snp.trailing).offset(12)
                $0.top.equalTo(primaryLabel.snp.bottom)
                $0.trailing.lessThanOrEqualToSuperview().inset(16)
            }
            scoreLabel.snp.remakeConstraints {
                $0.leading.equalTo(divider.snp.trailing).offset(8)
                $0.centerY.equalToSuperview()
                $0.width.equalTo(0)
            }
        }
    }

    private func applyAwayLayout(isGoal: Bool) {
        iconImageView.snp.remakeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(8)
            $0.size.equalTo(24)
        }
        minuteLabel.snp.remakeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(40)
            $0.height.equalTo(16)
        }
        divider.snp.remakeConstraints {
            $0.trailing.equalToSuperview().inset(55)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.width.equalTo(1)
        }

        if isGoal {
            scoreLabel.isHidden = false
            secondaryLabel.isHidden = true

            primaryLabel.textAlignment = .left
            primaryLabel.snp.remakeConstraints {
                $0.leading.equalToSuperview().inset(16)
                $0.centerY.equalToSuperview()
            }
            scoreLabel.textAlignment = .right
            scoreLabel.snp.remakeConstraints {
                $0.trailing.equalTo(divider.snp.leading).offset(-8)
                $0.leading.greaterThanOrEqualTo(primaryLabel.snp.trailing).offset(8)
                $0.centerY.equalToSuperview()
            }
            secondaryLabel.snp.remakeConstraints {
                $0.trailing.equalTo(divider.snp.leading).offset(-8)
                $0.centerY.equalToSuperview()
                $0.width.equalTo(0)
            }
        } else {
            // Primary (top) + secondary (bottom) stacked
            scoreLabel.isHidden = true
            secondaryLabel.isHidden = false

            primaryLabel.textAlignment = .right
            primaryLabel.snp.remakeConstraints {
                $0.leading.greaterThanOrEqualToSuperview().inset(16)
                $0.trailing.equalTo(divider.snp.leading).offset(-12)
                $0.top.equalToSuperview().inset(12)
            }
            secondaryLabel.textAlignment = .right
            secondaryLabel.snp.remakeConstraints {
                $0.leading.greaterThanOrEqualToSuperview().inset(16)
                $0.trailing.equalTo(divider.snp.leading).offset(-12)
                $0.top.equalTo(primaryLabel.snp.bottom)
            }
            scoreLabel.snp.remakeConstraints {
                $0.trailing.equalTo(divider.snp.leading).offset(-8)
                $0.centerY.equalToSuperview()
                $0.width.equalTo(0)
            }
        }
    }

    // MARK: - Helpers

    private func goalIcon(for sport: Sport, scoreDiff: Int) -> UIImage? {
        switch sport {
        case .basketball:
            switch scoreDiff {
            case 2: return UIImage(named: "2")
            case 3: return UIImage(named: "3")
            default: return UIImage(named: "basketball") 
            }
        default:
            return UIImage(named: "goal_point")
        }
    }

    private func defaultIcon(for sport: Sport) -> UIImage? {
        switch sport {
        case .basketball: return UIImage(named: "basketball")
        case .americanFootball: return UIImage(named: "amfootball")
        default: return UIImage(named: "goal_point")
        }
    }
}
