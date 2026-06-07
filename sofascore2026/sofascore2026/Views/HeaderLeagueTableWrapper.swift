//
//  LeagueSectionHeaderView.swift
//  sofascore2026
//
//  Created by akademija on 22.03.2026..
//

import UIKit
import SnapKit
final class HeaderLeagueTableWrapper: UITableViewHeaderFooterView {
    static let reuseIdentifier = "HeaderLeagueTableWrapper"

    private let headerLeagueView = HeaderLeagueView()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    var onLeagueTapped: (() -> Void)? {
        get { headerLeagueView.onLeagueTapped }
        set { headerLeagueView.onLeagueTapped = newValue }
    }

    func configure(with model: LeagueModel) {
        headerLeagueView.configure(with: model)
    }

    private func setupView() {
        contentView.backgroundColor = .white
        backgroundView = UIView()
        backgroundView?.backgroundColor = .white

        contentView.addSubview(headerLeagueView)
        headerLeagueView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
