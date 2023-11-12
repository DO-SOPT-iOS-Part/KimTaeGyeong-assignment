//
//  CustomTableHeaderView.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 11/8/23.
//

import UIKit

import SnapKit
import Then

class CustomTableHeaderView: UITableViewHeaderFooterView {
    
    static let identifier: String = "CustomTableHeaderView"
    
    let calendarImageView = UIImageView()
    let titleLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CustomTableHeaderView {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        calendarImageView.do {
            $0.image = UIImage(systemName: "calendar")
            $0.tintColor = UIColor.white.withAlphaComponent(0.3)
        }
        
        titleLabel.do {
            $0.text = "10일간의 일기예보"
            $0.textColor = UIColor.white.withAlphaComponent(0.3)
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        }
    }
    
    private func setLayout() {
        [calendarImageView, titleLabel].forEach {
            addSubview($0)
        }
        
        calendarImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(17)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(calendarImageView.snp.trailing).offset(5)
            $0.centerY.equalToSuperview()
        }
    }
    
}
