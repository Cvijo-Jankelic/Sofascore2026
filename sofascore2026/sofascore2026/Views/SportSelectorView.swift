//
//  SportSelectorView.swift
//  sofascore2026
//
//  Created by akademija on 21.03.2026..
//

import UIKit
import SofaAcademic
import SnapKit

final class SportSelectorView: BaseView {
    
    var onSportSelected: ((Sport) -> Void)?

    private let stackView = UIStackView()
    private let footballButtonView = SportSelectorButtonView()
    private let basketballButtonView = SportSelectorButtonView()
    private let americanFootballButtonView = SportSelectorButtonView()
    private let selectorLine = UIView()

    override func addViews() {
        addSubview(stackView)
        stackView.addArrangedSubview(footballButtonView)
        stackView.addArrangedSubview(basketballButtonView)
        stackView.addArrangedSubview(americanFootballButtonView)
        addSubview(selectorLine)
    }

    override func styleViews() {
        backgroundColor = .sofaLightBlue
        
        selectorLine.backgroundColor = .white
        selectorLine.layer.cornerRadius = 2
        selectorLine.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]


        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        footballButtonView.addTarget(self, action: #selector(didTapFootball), for: .touchUpInside)
        basketballButtonView.addTarget(self, action: #selector(didTapBasketball), for: .touchUpInside)
        americanFootballButtonView.addTarget(self, action: #selector(didTapAmericanFootball), for: .touchUpInside)
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        selectorLine.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.height.equalTo(4)
            $0.leading.trailing.equalTo(footballButtonView).inset(8)
        }
    }

    func configure(selectedSport: Sport) {
        updateSelection(to: selectedSport)
    }

    func updateSelection(to sport: Sport) {
        footballButtonView.configure(with: .football, isSelected: sport == .football)
        basketballButtonView.configure(with: .basketball, isSelected: sport == .basketball)
        americanFootballButtonView.configure(with: .americanFootball, isSelected: sport == .americanFootball)
        
        let selectedButton = buttonView(for: sport)
        UIView.animate(withDuration: 0.3) {
            self.selectorLine.snp.remakeConstraints {
                $0.bottom.equalToSuperview()
                $0.height.equalTo(4)
                $0.leading.trailing.equalTo(selectedButton).inset(8)
            }
            self.layoutIfNeeded()
        }
    }
    
    private func buttonView(for sport: Sport) -> SportSelectorButtonView {
        switch sport {
        case .football: return footballButtonView
        case .basketball: return basketballButtonView
        case .americanFootball: return americanFootballButtonView
        }
    }

    @objc private func didTapFootball() {
        onSportSelected?(.football)
    }

    @objc private func didTapBasketball() {
        onSportSelected?(.basketball)
    }

    @objc private func didTapAmericanFootball() {
        onSportSelected?(.americanFootball)
    }
}
