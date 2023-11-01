//
//  WeatherInfoView.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/20/23.
//

import UIKit

import SnapKit
import Then

class WeatherInfoView: UIView {
    
    weak var delegate: WeatherInfoViewDelegate?
    
    let backgroundImageView = UIImageView(image: UIImage(named: "background_image2"))
    let myLocationLabel = UILabel()
    let locationLabel = UILabel()
    let weatherLabel = UILabel()
    let temperatureLabel = UILabel()
    let maxtemperatureLabel = UILabel()
    let mintemperatureLabel = UILabel()
    
    init(location: String, weather: String, temperature: String, maxTemperature: String, minTemperature: String) {
        super.init(frame: .zero)
        self.bindData(location: location, weather: weather, temperature: temperature, maxTemperature: maxTemperature, minTemperature: minTemperature)
        self.setUI()
        self.setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WeatherInfoView {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        backgroundImageView.do {
            $0.contentMode = .scaleAspectFill
        }
        
        myLocationLabel.do {
            $0.text = "나의 위치"
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Bold", size: 25)
        }
        
        locationLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        }
        
        weatherLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        }
        
        temperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Light", size: 50)
        }
        
        maxtemperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        }
        
        mintemperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        }
    }
    
    private func setLayout() {
        [backgroundImageView, myLocationLabel, locationLabel, weatherLabel, temperatureLabel, maxtemperatureLabel, mintemperatureLabel].forEach {
            addSubview($0)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        myLocationLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(7)
            $0.leading.equalToSuperview().inset(15)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(myLocationLabel.snp.bottom)
            $0.leading.equalTo(myLocationLabel.snp.leading)
        }
        
        weatherLabel.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(7)
            $0.leading.equalTo(myLocationLabel)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(myLocationLabel)
            $0.trailing.equalToSuperview().inset(15)
        }
        
        mintemperatureLabel.snp.makeConstraints {
            $0.bottom.equalTo(weatherLabel)
            $0.trailing.equalTo(temperatureLabel)
        }
        
        maxtemperatureLabel.snp.makeConstraints {
            $0.bottom.equalTo(weatherLabel)
            $0.trailing.equalTo(mintemperatureLabel.snp.leading).offset(-5)
        }
    }
    
    private func bindData(location: String, weather: String, temperature: String, maxTemperature: String, minTemperature: String) {
        locationLabel.text = location
        weatherLabel.text = weather
        temperatureLabel.text = temperature
        maxtemperatureLabel.text = "최고:\(maxTemperature)"
        mintemperatureLabel.text = "최저:\(minTemperature)"
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.weatherInfoViewTapped(self)
    }
    
}
