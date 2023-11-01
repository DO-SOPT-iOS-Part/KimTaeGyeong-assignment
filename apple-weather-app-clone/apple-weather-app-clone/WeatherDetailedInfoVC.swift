//
//  WeatherDetailedInfoVC.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/21/23.
//

import UIKit

import SnapKit
import Then

class WeatherDetailedInfoVC: UIViewController {
    
    private let verticalScrollView = UIScrollView()
    private var contentView = UIView()
    private let locationLabel: UILabel = UILabel()
    private let temperatureLabel = UILabel()
    private let weatherLabel = UILabel()
    private let maxtemperatureLabel = UILabel()
    private let mintemperatureLabel = UILabel()
    private let descriptionView = UIView()
    private let descriptionLabel = UILabel()
    private let lineView = UIView()
    private let horizontalScrollView = UIScrollView()
    private var timelyWeatherContentView = UIView()
    private var timelyWeatherStackView = UIStackView()
    
    var timelyWeatherInfoViewList = [TimelyWeatherView(time: "1", weather: "cloudy", temperature: "25°"), TimelyWeatherView(time: "2", weather: "heavy rain", temperature: "24°"), TimelyWeatherView(time: "3", weather: "party cloudy", temperature: "23°"), TimelyWeatherView(time: "4", weather: "rain", temperature: "22°"), TimelyWeatherView(time: "5", weather: "thunderstorms", temperature: "21°"), TimelyWeatherView(time: "6", weather: "rain", temperature: "20°"), TimelyWeatherView(time: "7", weather: "party cloudy", temperature: "20°"), TimelyWeatherView(time: "8", weather: "heavy rain", temperature: "21°"), TimelyWeatherView(time: "9", weather: "cloudy", temperature: "22°"), TimelyWeatherView(time: "10", weather: "cloudy", temperature: "23°"), TimelyWeatherView(time: "11", weather: "cloudy", temperature: "24°"), TimelyWeatherView(time: "12", weather: "cloudy", temperature: "25°")]
    
    init(location: String, temperature: String, weather: String, maxTemperature: String, minTemperature: String) {
        locationLabel.text = location
        temperatureLabel.text = temperature
        weatherLabel.text = weather
        maxtemperatureLabel.text = maxTemperature
        mintemperatureLabel.text = minTemperature
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.setBackgroundImage()
        self.setUI()
    }
    
}

extension WeatherDetailedInfoVC {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        verticalScrollView.do {
            $0.alwaysBounceVertical = true
            $0.showsVerticalScrollIndicator = false
        }
        
        locationLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 45)
        }
        
        temperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Light", size: 75)
        }
        
        weatherLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 25)
        }
        
        maxtemperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 23)
        }
        
        mintemperatureLabel.do {
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 23)
        }
        
        descriptionView.do {
            $0.backgroundColor = UIColor.black.withAlphaComponent(0.2)
            $0.layer.cornerRadius = 20
        }
        
        descriptionLabel.do {
            $0.text = "08:00~09:00에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
            $0.numberOfLines = 0
            $0.textColor = .white
            $0.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        }
        
        lineView.do {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        }
        
        horizontalScrollView.do {
            $0.showsHorizontalScrollIndicator = false
        }
        
        timelyWeatherStackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.spacing = 10
        }
    }
    
    private func setLayout() {
        self.view.addSubview(verticalScrollView)
        
        verticalScrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        verticalScrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(verticalScrollView)
            $0.width.equalTo(verticalScrollView)
            $0.height.greaterThanOrEqualTo(verticalScrollView.snp.height)
        }
        
        [locationLabel, temperatureLabel, weatherLabel, maxtemperatureLabel, mintemperatureLabel, descriptionView].forEach {
            contentView.addSubview($0)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).inset(20)
            $0.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(locationLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        maxtemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherLabel.snp.bottom).offset(3)
            $0.trailing.equalTo(view.snp.centerX).offset(-3)
        }
        
        mintemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(maxtemperatureLabel)
            $0.leading.equalTo(view.snp.centerX).offset(3)
        }
        
        descriptionView.snp.makeConstraints {
            $0.top.equalTo(maxtemperatureLabel.snp.bottom).offset(50)
            $0.leading.trailing.equalTo(contentView).inset(17)
        }
        
        [descriptionLabel, lineView, horizontalScrollView].forEach {
            descriptionView.addSubview($0)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionView).inset(8)
            $0.leading.trailing.equalTo(descriptionView).inset(13)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(descriptionView).inset(13)
            $0.height.equalTo(0.3)
        }
        
        horizontalScrollView.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom)
            $0.bottom.leading.trailing.equalTo(descriptionView)
        }
        
        horizontalScrollView.addSubview(timelyWeatherStackView)
        
        timelyWeatherStackView.snp.makeConstraints {
            $0.edges.equalTo(horizontalScrollView.contentLayoutGuide)
            $0.height.equalTo(horizontalScrollView)
        }
        
        timelyWeatherInfoViewList.forEach { view in
            timelyWeatherStackView.addArrangedSubview(view)
            view.snp.makeConstraints {
                $0.width.equalTo(65)
                $0.height.equalTo(105)
            }
        }
    }
    
    private func setBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "background_image1"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        view.insertSubview(backgroundImageView, at: 0)
    }
    
}
