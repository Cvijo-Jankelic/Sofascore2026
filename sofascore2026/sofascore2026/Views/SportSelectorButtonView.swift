//
//  SportSelectorButtonView.swift
//  sofascore2026
//
//  Created by akademija on 21.03.2026..
//

import UIKit
import SnapKit

class SportSelectorButtonView: UIControl{
    private let iconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let selectorLine = UIView()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        styleViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews(){
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(selectorLine)
    }
    
    private func styleViews(){
        backgroundColor = .clear

        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .white
        
        titleLabel.font = .sportSelectorTitle
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.75

        selectorLine.backgroundColor = .white
        selectorLine.layer.cornerRadius = 2
        selectorLine.isHidden = true
    }
    
    private func setupConstraints(){
        iconImageView.snp.makeConstraints{
            $0.size.equalTo(16)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(4)
        }
        
        titleLabel.snp.makeConstraints{
            $0.width.equalTo(104)
            $0.height.equalTo(16)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8)
        }
        
        selectorLine.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(4)
        }
    }
    
    func configure(with sport: Sport, isSelected: Bool){
        titleLabel.text = sport.title
        iconImageView.image = UIImage(named: sport.icon)
        selectorLine.isHidden = !isSelected
    }
    
}
