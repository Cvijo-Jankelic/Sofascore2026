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
    
    private let logoImageView = UIImageView()
    private let trophyButton = UIButton()
    private let settingsButton = UIButton()
    private let buttonStack = UIStackView()
    
    override func addViews(){
        addSubview(logoImageView)
        addSubview(buttonStack)
        buttonStack.addArrangedSubview(trophyButton)
        buttonStack.addArrangedSubview(settingsButton)
    }
    
    override func styleViews(){
        backgroundColor = .sofaLightBlue
        
        logoImageView.image = UIImage(named: "sofascore_lockup")
        logoImageView.contentMode = .scaleAspectFit
        
        buttonStack.axis = .horizontal
        
        trophyButton.setImage(UIImage(named: "ic_trophy"), for: .normal)
        trophyButton.tintColor = .white
        
        settingsButton.setImage(UIImage(named: "ic_settings"), for: .normal)
        settingsButton.tintColor = .white
        
        let inset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        trophyButton.contentEdgeInsets = inset
        settingsButton.contentEdgeInsets = inset
        
    }
    
    override func setupConstraints(){
        logoImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(14)
        }
        
        buttonStack.snp.makeConstraints{
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
