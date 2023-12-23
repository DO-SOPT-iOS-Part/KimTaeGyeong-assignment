//
//  WeatherDetailedInfoView.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 11/6/23.
//

import UIKit

import SnapKit
import Then

class WeatherDetailedInfoView: UIView {
    
    private let locationLabel: UILabel = UILabel()
    private let temperatureLabel = UILabel()
    private let weatherLabel = UILabel()
    private let stackView = UIStackView()
    private let maxTemperatureLabel = UILabel()
    private let minTemperatureLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WeatherDetailedInfoView {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        locationLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 45)
        }
        
        temperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Thin", size: 108)
        }
        
        weatherLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 25)
        }
        
        stackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 10
        }
        
        maxTemperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 23)
        }
        
        minTemperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 23)
        }
    }
    
    private func setLayout() {
        [locationLabel, temperatureLabel, weatherLabel, stackView].forEach {
            addSubview($0)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom)
            $0.centerX.equalToSuperview().offset(10)
        }
        
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(weatherLabel.snp.bottom).offset(3)
            $0.centerX.equalToSuperview()
        }
        
        [maxTemperatureLabel, minTemperatureLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    func bindData(data: WeatherInfoListData) {
        self.locationLabel.text = data.location
        self.temperatureLabel.text = "\(data.temperature)°"
        self.weatherLabel.text = data.weather
        self.maxTemperatureLabel.text = "최고:\(data.maxTemperature)°"
        self.minTemperatureLabel.text = "최저:\(data.minTemperature)°"
    }
    
}
