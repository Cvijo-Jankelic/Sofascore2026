//
//  AppHeaderView.swift
//  sofascore2026
//
//  Created by akademija on 27.03.2026..
//

import UIKit
import SnapKit
import SofaAcademic

final class AppHeaderView: BaseView {
    
    var onSettingsTapped: (() -> Void)?
    
    private let buttonStack = UIStackView()
    private let logoImageView = UIImageView()
    private let trophyButton = UIButton()
    private let settingsButton = UIButton()
    
    override func addViews(){
        addSubview(buttonStack)
        addSubview(logoImageView)
        buttonStack.addArrangedSubview(trophyButton)
        buttonStack.addArrangedSubview(settingsButton)
    }
    
    override func styleViews(){
        backgroundColor = .sofaLightBlue
        
        logoImageView.image = UIImage(named: "sofascore_lockup")
        logoImageView.contentMode = .scaleAspectFit
        
        buttonStack.axis = .horizontal
        
        var trophyConfig = UIButton.Configuration.plain()
        trophyConfig.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        trophyConfig.image = UIImage(named: "ic_trophy")
        trophyConfig.baseForegroundColor = .white
        trophyButton.configuration = trophyConfig
        
        var settingsConfig = UIButton.Configuration.plain()
        
        settingsConfig.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        settingsConfig.image = UIImage(named: "ic_settings")
        settingsConfig.baseForegroundColor = .white
        settingsButton.configuration = settingsConfig
        
    }
    
        override func setupConstraints(){
            logoImageView.snp.makeConstraints {
                $0.leading.equalToSuperview().inset(16).priority(.high)
                $0.centerY.equalToSuperview()
                $0.height.equalTo(20)
            }
            
            buttonStack.snp.makeConstraints{
                $0.leading.greaterThanOrEqualTo(logoImageView.snp.trailing).offset(8)
                $0.trailing.equalToSuperview().inset(4)
                $0.top.bottom.equalToSuperview()
            }
        }
    
    override func setupGestureRecognizers() {
        settingsButton.addTarget(self, action: #selector(didTapSettings), for: .touchUpInside)
    }
    
    @objc private func didTapSettings() {
            onSettingsTapped?()
        }
    
}
