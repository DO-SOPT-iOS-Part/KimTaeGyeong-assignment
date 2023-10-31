//
//  TimelyWeatherView.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/21/23.
//

import UIKit

class TimelyWeatherView: UIView {
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Medium", size: 19)
        return label
    }()
    
    init(time: String, weather: String, temperature: String) {
        super.init(frame: .zero)
        timeLabel.text = "\(time)시"
        setWeatherImage(weather: weather)
        temperatureLabel.text = "\(temperature)"
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [timeLabel, weatherImageView, temperatureLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            timeLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 10),
            weatherImageView.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            temperatureLabel.centerXAnchor.constraint(equalTo: timeLabel.centerXAnchor)
        ])
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
}
