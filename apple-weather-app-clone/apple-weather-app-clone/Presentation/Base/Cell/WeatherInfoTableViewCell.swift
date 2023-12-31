//
//  WeatherInfoTableViewCell.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/20/23.
//

import UIKit

import SnapKit
import Then

class WeatherInfoTableViewCell: UITableViewCell {
    
    static let identifier: String = "WeatherInfoTableViewCell"
    
    private let backgroundImageView = UIImageView(image: UIImage(named: "background_image2"))
    private let locationLabel = UILabel()
    private let timeLabel = UILabel()
    private let weatherLabel = UILabel()
    private let temperatureLabel = UILabel()
    private let maxTemperatureLabel = UILabel()
    private let minTemperatureLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
}

extension WeatherInfoTableViewCell {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        backgroundImageView.do {
            $0.contentMode = .scaleAspectFill
        }
        
        locationLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Bold", size: 25)
        }
        
        timeLabel.do {
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
        
        maxTemperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        }
        
        minTemperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        }
    }
    
    private func setLayout() {
        [backgroundImageView, locationLabel, timeLabel, weatherLabel, temperatureLabel, maxTemperatureLabel, minTemperatureLabel].forEach {
            contentView.addSubview($0)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(7)
            $0.leading.equalTo(contentView).inset(15)
        }
        
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom)
            $0.leading.equalTo(locationLabel.snp.leading)
        }
        
        weatherLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView).inset(7)
            $0.leading.equalTo(locationLabel)
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel)
            $0.trailing.equalTo(contentView).inset(15)
        }
        
        minTemperatureLabel.snp.makeConstraints {
            $0.bottom.equalTo(weatherLabel)
            $0.trailing.equalTo(temperatureLabel)
        }
        
        maxTemperatureLabel.snp.makeConstraints {
            $0.bottom.equalTo(weatherLabel)
            $0.trailing.equalTo(minTemperatureLabel.snp.leading).offset(-5)
        }
    }
    
    func bindData(data: WeatherInfoListData) {
        self.locationLabel.text = data.location
        self.timeLabel.text = data.time
        self.weatherLabel.text = data.weather
        self.temperatureLabel.text = "\(data.temperature)°"
        self.maxTemperatureLabel.text = "최고:\(data.maxTemperature)°"
        self.minTemperatureLabel.text = "최저:\(data.minTemperature)°"
    }
    
}
