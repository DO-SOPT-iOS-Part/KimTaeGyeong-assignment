//
//  TimelyWeatherView.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/21/23.
//

import UIKit

import SnapKit
import Then

class TimelyWeatherView: UIView {
    
    private let timeLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let temperatureLabel = UILabel()
    
    init(time: String, weather: String, temperature: String) {
        super.init(frame: .zero)
        self.bindData(time: time, weather: weather, temperature: temperature)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TimelyWeatherView {
    
    private func bindData(time: String, weather: String, temperature: String) {
        timeLabel.text = "\(time)시"
        setWeatherImage(weather: weather)
        temperatureLabel.text = "\(temperature)"
    }
    
    private func setWeatherImage(weather: String) {
        switch weather {
        case "cloudy":
            weatherImageView.image = UIImage(named: "cloudy_image")
        case "heavy rain":
            weatherImageView.image = UIImage(named: "heavy_rain_image")
        case "party cloudy":
            weatherImageView.image = UIImage(named: "party_cloudy_image")
        case "rain":
            weatherImageView.image = UIImage(named: "rain_image")
        case "thunderstorms":
            weatherImageView.image = UIImage(named: "thunderstorms_image")
        default:
            weatherImageView.image = UIImage(named: "cloudy_image")
        }
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        timeLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        }
        
        weatherImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        temperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 19)
        }
    }
    
    private func setLayout() {
        [timeLabel, weatherImageView, temperatureLabel].forEach {
            addSubview($0)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
        }
        
        weatherImageView.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(10)
            $0.centerX.equalTo(timeLabel)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(10)
            $0.centerX.equalTo(timeLabel)
        }
    }
    
}
