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
        case "흐림":
            weatherImageView.image = UIImage(named: "cloudy_image")
        case "폭우":
            weatherImageView.image = UIImage(named: "heavy_rain_image")
        case "다소 흐림":
            weatherImageView.image = UIImage(named: "party_cloudy_image")
        case "비":
            weatherImageView.image = UIImage(named: "rain_image")
        case "번개":
            weatherImageView.image = UIImage(named: "thunderstorms_image")
        default:
            weatherImageView.image = UIImage(named: "cloudy_image")
        }
    }
    
}
