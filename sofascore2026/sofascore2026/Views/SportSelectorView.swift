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
    
    var onSportSelected: ((Sport    ) -> Void)?

    private let stackView = UIStackView()
    private let footballButtonView = SportSelectorButtonView()
    private let basketballButtonView = SportSelectorButtonView()
    private let americanFootballButtonView = SportSelectorButtonView()

    override func addViews() {
        addSubview(stackView)

        stackView.addArrangedSubview(footballButtonView)
        stackView.addArrangedSubview(basketballButtonView)
        stackView.addArrangedSubview(americanFootballButtonView)
    }

    override func styleViews() {
        backgroundColor = .sofaLightBlue

        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
    }

    override func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(48)
        }
    }

    func configure(selectedSport: Sport) {
        footballButtonView.addTarget(self, action: #selector(didTapFootball), for: .touchUpInside)
        basketballButtonView.addTarget(self, action: #selector(didTapBasketball), for: .touchUpInside)
        americanFootballButtonView.addTarget(self, action: #selector(didTapAmericanFootball), for: .touchUpInside)
        updateSelection(to: selectedSport)
    }

    func updateSelection(to sport: Sport) {
        footballButtonView.configure(with: .football, isSelected: sport == .football)
        basketballButtonView.configure(with: .basketball, isSelected: sport == .basketball)
        americanFootballButtonView.configure(with: .americanFootball, isSelected: sport == .americanFootball)
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
