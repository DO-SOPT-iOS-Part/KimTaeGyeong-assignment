//
//  WeatherInfoView.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/20/23.
//

import UIKit

class WeatherInfoView: UIView {
    
    weak var delegate: WeatherInfoViewDelegate?
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "background_image2"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let myLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "나의 위치"
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Bold", size: 25)
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Medium", size: 16)
        return label
    }()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Regular", size: 15)
        return label
    }()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Light", size: 50)
        return label
    }()
    
    let maxtemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        return label
    }()
    
    let mintemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Medium", size: 15)
        return label
    }()
    
    init(location: String, weather: String, temperature: String, maxTemperature: String, minTemperature: String) {
        super.init(frame: .zero)
        locationLabel.text = location
        weatherLabel.text = weather
        temperatureLabel.text = temperature
        maxtemperatureLabel.text = "최고:\(maxTemperature)"
        mintemperatureLabel.text = "최저:\(minTemperature)"
        
        self.setLayout()
        self.setupGestureRecognizers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [backgroundImageView, myLocationLabel, locationLabel, weatherLabel, temperatureLabel, maxtemperatureLabel, mintemperatureLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            myLocationLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            myLocationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: myLocationLabel.bottomAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: myLocationLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            weatherLabel.leadingAnchor.constraint(equalTo: myLocationLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: myLocationLabel.topAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            mintemperatureLabel.bottomAnchor.constraint(equalTo: weatherLabel.bottomAnchor),
            mintemperatureLabel.trailingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            maxtemperatureLabel.bottomAnchor.constraint(equalTo: weatherLabel.bottomAnchor),
            maxtemperatureLabel.trailingAnchor.constraint(equalTo: mintemperatureLabel.leadingAnchor, constant: -5)
        ])
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.weatherInfoViewTapped(self)
    }
    
}
