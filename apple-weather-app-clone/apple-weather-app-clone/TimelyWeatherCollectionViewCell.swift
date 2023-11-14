//
//  TimelyWeatherCollectionViewCell.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/21/23.
//

import UIKit

import SnapKit
import Then

class TimelyWeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "TimelyWeatherCollectionViewCell"
    
    private let stackView = UIStackView()
    private let timeLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let temperatureLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TimelyWeatherCollectionViewCell {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        stackView.do {
            $0.axis = .vertical
            $0.alignment = .center
            $0.distribution = .equalSpacing        }
        
        timeLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        }
        
        weatherImageView.do {
            $0.contentMode = .scaleAspectFit
        }
        
        temperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Medium", size: 18)
        }
    }
    
    private func setLayout() {
        contentView.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview()
        }
        
        [timeLabel, weatherImageView, temperatureLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        weatherImageView.snp.makeConstraints {
            $0.size.equalTo(20)
        }
    }
    
    func bindData(data: TimelyWeatherListData) {
        timeLabel.text = "\(data.time)"
        setWeatherImage(weather: data.weather)
        temperatureLabel.text = "\(data.temperatue)°"
    }
    
    private func setWeatherImage(weather: String) {
        switch weather {
        case "Thunderstorm":
            weatherImageView.image = UIImage(systemName: "cloud.bolt.rain.fill")?.withRenderingMode(.alwaysOriginal)
        case "Drizzle":
            weatherImageView.image = UIImage(systemName: "cloud.drizzle.fill")?.withRenderingMode(.alwaysOriginal)
        case "Rain":
            weatherImageView.image = UIImage(systemName: "cloud.rain.fill")?.withRenderingMode(.alwaysOriginal)
        case "Snow":
            weatherImageView.image = UIImage(systemName: "cloud.snow.fill")?.withRenderingMode(.alwaysOriginal)
        case "Atmosphere":
            weatherImageView.image = UIImage(systemName: "smoke.fill")?.withRenderingMode(.alwaysOriginal)
        case "Clear":
            weatherImageView.image = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal)
        case "Clouds":
            weatherImageView.image = UIImage(systemName: "cloud.fill")?.withRenderingMode(.alwaysOriginal)
        case "Additional":
            weatherImageView.image = UIImage(systemName: "hurricane")?.withRenderingMode(.alwaysOriginal)
        default:
            weatherImageView.image = UIImage(systemName: "sun.max.fill")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
}
