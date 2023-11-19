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
    
    func bindData(time: String) {
        let time1 = adjustTime1(time: time)!
        let time2 = adjustTime2(time: time)!
        descriptionLabel.text = "\(time1)~\(time2)에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
    }
    
    private func adjustTime1(time: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let date = dateFormatter.date(from: time) {
            let adjustedTime = Calendar.current.date(byAdding: .minute, value: -Calendar.current.component(.minute, from: date), to: date)
            if let adjustedTime = adjustedTime {
                return dateFormatter.string(from: adjustedTime)
            }
        }
        return nil
    }
    
    private func adjustTime2(time: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        if let date = dateFormatter.date(from: time) {
            let addedTime = Calendar.current.date(byAdding: .hour, value: 1, to: date)
            let adjustedTime = Calendar.current.date(byAdding: .minute, value: -Calendar.current.component(.minute, from: date), to: addedTime ?? Date())
            if let adjustedTime = adjustedTime {
                return dateFormatter.string(from: adjustedTime)
            }
        }
        return nil
    }
    
}
