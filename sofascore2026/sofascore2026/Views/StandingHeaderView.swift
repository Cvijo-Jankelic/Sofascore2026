import UIKit
import SnapKit
import SofaAcademic

// Figma: Standings/Football/Standings Cell Head — 360×48
// Columns must align pixel-perfect with StandingRowCell body columns.
final class StandingHeaderView: BaseView {

    private let hashLabel = UILabel()     // "#"
    private let teamLabel = UILabel()     // "Team"
    private let pLabel = UILabel()        // "P"
    private let wLabel = UILabel()        // "W"
    private let dLabel = UILabel()        // "D"
    private let lLabel = UILabel()        // "L"
    private let ptsLabel = UILabel()      // "PTS"
    private let separator = UIView()

    override func addViews() {
        addSubview(hashLabel)
        addSubview(teamLabel)
        addSubview(pLabel)
        addSubview(wLabel)
        addSubview(dLabel)
        addSubview(lLabel)
        addSubview(ptsLabel)
        addSubview(separator)
    }

    override func styleViews() {
        backgroundColor = .white

        [hashLabel, teamLabel, pLabel, wLabel, dLabel, lLabel, ptsLabel].forEach {
            $0.font = .standingSecondary
            $0.textColor = .secondaryText
        }

        hashLabel.textAlignment = .center
        pLabel.textAlignment = .center
        wLabel.textAlignment = .center
        dLabel.textAlignment = .center
        lLabel.textAlignment = .center
        ptsLabel.textAlignment = .center
        teamLabel.textAlignment = .left

        hashLabel.text = "#"
        teamLabel.text = "Team"
        pLabel.text = "P"
        wLabel.text = "W"
        dLabel.text = "D"
        lLabel.text = "L"
        ptsLabel.text = "PTS"

        separator.backgroundColor = UIColor(red: 18/255, green: 18/255, blue: 18/255, alpha: 0.1)
    }

    override func setupConstraints() {
        // Left zone — mirrors body: position(w=24) + logo(16) gap
        // "#" aligns with position badge center (body: leading=8 w=24 → center x=20)
        hashLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        // "Team" aligns with teamNameLabel in body (body: leading = logo.trailing+8 = 40+16+8 = 64)
        teamLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(64)
            $0.centerY.equalToSuperview()
        }

        // Stats columns — IDENTICAL chain to StandingRowCell (trailing anchor)
        ptsLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        lLabel.snp.makeConstraints {
            $0.trailing.equalTo(ptsLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        dLabel.snp.makeConstraints {
            $0.trailing.equalTo(lLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        wLabel.snp.makeConstraints {
            $0.trailing.equalTo(dLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        pLabel.snp.makeConstraints {
            $0.trailing.equalTo(wLabel.snp.leading).offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(24)
        }

        separator.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
}
