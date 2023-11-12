//
//  WeatherForecastTableViewCell.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 11/4/23.
//

import UIKit

class WeatherForecastTableViewCell: UITableViewCell {
    
    static let identifier: String = "WeatherForecastTableViewCell"
    
    private let lineView = UIView()
    private let dayLabel = UILabel()
    private let stackView = UIStackView()
    private let weatherImageView = UIImageView()
    private let rainGaugeLabel = UILabel()
    private let minTemperatureLabel = UILabel()
    private let temperatureBarImageView = UIImageView()
    private let maxTemperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WeatherForecastTableViewCell {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        lineView.do {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        }
        
        dayLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 20)
            $0.textAlignment = .left
        }
        
        stackView.do {
            $0.alignment = .center
            $0.axis = .vertical
            $0.spacing = 1
        }
        
        weatherImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        rainGaugeLabel.do {
            $0.textColor = UIColor(red: 129/255, green: 207/255, blue: 250/255, alpha: 1.0)
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 13)
        }
        
        minTemperatureLabel.do {
            $0.textColor = UIColor.white.withAlphaComponent(0.3)
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 19)
            $0.textAlignment = .right
        }
        
        temperatureBarImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        maxTemperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 19)
            $0.textAlignment = .right
        }
        
    }
    
    private func setLayout() {
        [lineView, dayLabel, stackView, maxTemperatureLabel, minTemperatureLabel, temperatureBarImageView].forEach {
            self.contentView.addSubview($0)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        dayLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(41)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(dayLabel.snp.trailing).offset(25)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(33)
        }
        
        stackView.addArrangedSubview(weatherImageView)
        
        weatherImageView.snp.makeConstraints {
            $0.width.height.equalTo(25)
        }
        
        minTemperatureLabel.snp.makeConstraints {
            $0.trailing.equalTo(temperatureBarImageView.snp.leading).offset(-5)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40)
        }
        
        temperatureBarImageView.snp.makeConstraints {
            $0.trailing.equalTo(maxTemperatureLabel.snp.leading).offset(-5)
            $0.centerY.equalToSuperview()
        }
        
        maxTemperatureLabel.snp.makeConstraints {
            $0.trailing.equalTo(lineView)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(40)
        }
    }
    
    func bindData(data: WeatherForecastListData) {
        self.dayLabel.text = data.day
        self.setWeatherImage(weather: data.weather)
        self.maxTemperatureLabel.text = "\(data.maxTemperature)°"
        self.temperatureBarImageView.image = UIImage(named: data.image)
        self.minTemperatureLabel.text = "\(data.minTemperature)°"
        self.rainGaugeLabel.text = "\(data.rainGauge)%"
    }
    
    private func setWeatherImage(weather: String) {
        switch weather {
        case "맑음":
            weatherImageView.image = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal)
        case "흐림":
            weatherImageView.image = UIImage(systemName: "cloud.fill")?.withRenderingMode(.alwaysOriginal)
        case "비":
            weatherImageView.image = UIImage(systemName: "cloud.rain.fill")?.withRenderingMode(.alwaysOriginal)
            stackView.addArrangedSubview(rainGaugeLabel)
        default:
            weatherImageView.image = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
}
