import UIKit
import SnapKit
import SofaAcademic

final class TeamInfoView: BaseView {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let managerRow = TeamInfoRowView()
    private let playersRow = TeamInfoRowView()
    private let venueRow = TeamInfoRowView()

    override func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(managerRow)
        contentView.addSubview(playersRow)
        contentView.addSubview(venueRow)
    }

    override func styleViews() {
        backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
    }

    override func setupConstraints() {
        scrollView.snp.makeConstraints { $0.edges.equalToSuperview() }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        managerRow.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }

        playersRow.snp.makeConstraints {
            $0.top.equalTo(managerRow.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }

        venueRow.snp.makeConstraints {
            $0.top.equalTo(playersRow.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.equalTo(52)
        }
    }

    func configure(with team: TeamModel) {
        managerRow.configure(label: "Manager", value: team.managerName ?? "-")
        playersRow.configure(label: "Total players", value: team.totalPlayers.map { "\($0)" } ?? "-")
        venueRow.configure(label: "Venue", value: team.venue ?? "-")
    }
}
