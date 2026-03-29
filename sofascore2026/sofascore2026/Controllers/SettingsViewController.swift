//
//  SettingsViewController.swift
//  sofascore2026
//
//  Created by akademija on 27.03.2026..
//

import UIKit
import SnapKit

final class SettingsViewController: UIViewController {
    
    private let titleLabel = UILabel()
    private let dismissButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleViews()
    }
    
    private func styleViews() {
        
        let contentView = UIView()
        contentView.backgroundColor = .white
        view.addSubview(contentView)
                
        contentView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        view.backgroundColor = .sofaLightBlue
        
        titleLabel.text = "Settings"
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .black
        
        dismissButton.setTitle("Done", for: .normal)
        dismissButton.setTitleColor(.sofaLightBlue, for: .normal)
        dismissButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .semibold)
        dismissButton.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dismissButton)
        
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(16)
        }
        
        dismissButton.snp.makeConstraints {
            $0.centerX.equalTo(titleLabel)
            $0.centerY.equalToSuperview().multipliedBy(2.0/3.0)
            $0.top.equalTo(titleLabel).offset(24)
            $0.height.equalTo(44)
        }
        
    }
    
    @objc private func didTapDismiss() {
        dismiss(animated: true)
    }
}
