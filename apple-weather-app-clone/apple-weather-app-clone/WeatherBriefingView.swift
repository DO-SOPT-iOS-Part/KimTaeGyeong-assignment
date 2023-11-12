//
//  WeatherBriefingView.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 11/6/23.
//

import UIKit

import SnapKit
import Then

class WeatherBriefingView: UIView {
    
    private let descriptionLabel = UILabel()
    private let lineView = UIView()
    
    init() {
        super.init(frame: .zero)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WeatherBriefingView {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        descriptionLabel.do {
            $0.numberOfLines = 0
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        }
        
        lineView.do {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        }
    }
    
    private func setLayout() {
        [descriptionLabel, lineView].forEach {
            addSubview($0)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            $0.bottom.equalTo(descriptionLabel.snp.bottom).offset(10)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    func bindData(text: String) {
        descriptionLabel.text = text
    }
    
}
