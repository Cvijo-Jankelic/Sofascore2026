import UIKit
import SnapKit
import SofaAcademic

final class TeamDetailView: BaseView {

    private let tabBar = UISegmentedControl(items: ["Details", "Players"])
    let infoView = TeamInfoView()
    let squadView = TeamSquadView()

    override func addViews() {
        addSubview(tabBar)
        addSubview(infoView)
        addSubview(squadView)
    }

    override func styleViews() {
        backgroundColor = .white
        tabBar.selectedSegmentIndex = 0
        squadView.isHidden = true
    }

    override func setupConstraints() {
        tabBar.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        infoView.snp.makeConstraints {
            $0.top.equalTo(tabBar.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }

        squadView.snp.makeConstraints {
            $0.top.equalTo(tabBar.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }

    override func setupGestureRecognizers() {
        tabBar.addTarget(self, action: #selector(tabChanged), for: .valueChanged)
    }

    @objc private func tabChanged() {
        let showInfo = tabBar.selectedSegmentIndex == 0
        infoView.isHidden = !showInfo
        squadView.isHidden = showInfo
    }
}
