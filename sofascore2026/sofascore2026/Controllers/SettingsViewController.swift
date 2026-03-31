//
//  SettingsViewController.swift
//  sofascore2026
//
//  Created by akademija on 27.03.2026..
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    private let contentView = UIView()
    private let titleLabel = UILabel()
    private let dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        styleViews()
        setupConstraints()
    }
    
    private func addViews() {
        view.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(dismissButton)
    }
    
    private func styleViews() {
        view.backgroundColor = .sofaLightBlue
        contentView.backgroundColor = .white
        
        titleLabel.text = "Settings"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .black
        
        dismissButton.setTitle("Done", for: .normal)
        dismissButton.setTitleColor(.sofaLightBlue, for: .normal)
        dismissButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        contentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
        }
        
        dismissButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().dividedBy(3)
        }
    }
    
    @objc private func didTapDismiss() {
        dismiss(animated: true)
    }
}
