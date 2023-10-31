//
//  WeatherDetailedInfoVC.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/21/23.
//

import UIKit

class WeatherDetailedInfoVC: UIViewController {
    
    private let customBottomBar = CustomBottomBarView()
    
    private let verticalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private var contentView = UIView()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Regular", size: 45)
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Light", size: 75)
        return label
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Regular", size: 25)
        return label
    }()
    
    private let maxtemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Regular", size: 23)
        return label
    }()
    
    private let mintemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Regular", size: 23)
        return label
    }()
    
    private let descriptionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "08:00~09:00에 강우 상태가, 18:00에 한때 흐린 상태가 예상됩니다."
        label.numberOfLines = 0
        label.textColor = .white
        label.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return view
    }()
    
    private let horizontalScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private var timelyWeatherContentView = UIView()
    
    private var timelyWeatherStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    let timelyWeatherInfoView1 = TimelyWeatherView(time: "1", weather: "cloudy", temperature: "25°")
    let timelyWeatherInfoView2 = TimelyWeatherView(time: "2", weather: "heavy rain", temperature: "24°")
    let timelyWeatherInfoView3 = TimelyWeatherView(time: "3", weather: "party cloudy", temperature: "23°")
    let timelyWeatherInfoView4 = TimelyWeatherView(time: "4", weather: "rain", temperature: "22°")
    let timelyWeatherInfoView5 = TimelyWeatherView(time: "5", weather: "thunderstorms", temperature: "21°")
    let timelyWeatherInfoView6 = TimelyWeatherView(time: "6", weather: "rain", temperature: "20°")
    let timelyWeatherInfoView7 = TimelyWeatherView(time: "7", weather: "party cloudy", temperature: "20°")
    let timelyWeatherInfoView8 = TimelyWeatherView(time: "8", weather: "heavy rain", temperature: "21°")
    let timelyWeatherInfoView9 = TimelyWeatherView(time: "9", weather: "cloudy", temperature: "22°")
    let timelyWeatherInfoView10 = TimelyWeatherView(time: "10", weather: "cloudy", temperature: "23°")
    let timelyWeatherInfoView11 = TimelyWeatherView(time: "11", weather: "cloudy", temperature: "24°")
    let timelyWeatherInfoView12 = TimelyWeatherView(time: "12", weather: "cloudy", temperature: "25°")
    
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
        self.setBackgroundImage()
        self.setLayout()
        
        customBottomBar.delegate = self
    }
    
}

extension WeatherDetailedInfoVC {
    
    private func setLayout() {
        [customBottomBar,verticalScrollView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            customBottomBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            customBottomBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            customBottomBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            customBottomBar.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        NSLayoutConstraint.activate([
            verticalScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            verticalScrollView.bottomAnchor.constraint(equalTo: customBottomBar.topAnchor),
            verticalScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            verticalScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        verticalScrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: verticalScrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: verticalScrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: verticalScrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: verticalScrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: verticalScrollView.widthAnchor),
            contentView.heightAnchor.constraint(greaterThanOrEqualTo: verticalScrollView.heightAnchor)
        ])
        
        [locationLabel, temperatureLabel, weatherLabel, maxtemperatureLabel, mintemperatureLabel, descriptionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            locationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            temperatureLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            weatherLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5),
            weatherLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            maxtemperatureLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 3),
            maxtemperatureLabel.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -3)
        ])
        
        NSLayoutConstraint.activate([
            mintemperatureLabel.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 3),
            mintemperatureLabel.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 3)
        ])
        
        NSLayoutConstraint.activate([
            descriptionView.topAnchor.constraint(equalTo: maxtemperatureLabel.bottomAnchor, constant: 50),
            descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17),
        ])
        
        [descriptionLabel, lineView, horizontalScrollView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            descriptionView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: descriptionView.topAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 13),
            descriptionLabel.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -13)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor, constant: 13),
            lineView.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor, constant: -13),
            lineView.heightAnchor.constraint(equalToConstant: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            horizontalScrollView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
            horizontalScrollView.bottomAnchor.constraint(equalTo: descriptionView.bottomAnchor),
            horizontalScrollView.leadingAnchor.constraint(equalTo: descriptionView.leadingAnchor),
            horizontalScrollView.trailingAnchor.constraint(equalTo: descriptionView.trailingAnchor)
        ])
        
        horizontalScrollView.addSubview(timelyWeatherStackView)
        timelyWeatherStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timelyWeatherStackView.topAnchor.constraint(equalTo: horizontalScrollView.contentLayoutGuide.topAnchor),
            timelyWeatherStackView.bottomAnchor.constraint(equalTo: horizontalScrollView.contentLayoutGuide.bottomAnchor),
            timelyWeatherStackView.leadingAnchor.constraint(equalTo: horizontalScrollView.contentLayoutGuide.leadingAnchor),
            timelyWeatherStackView.trailingAnchor.constraint(equalTo: horizontalScrollView.contentLayoutGuide.trailingAnchor),
            timelyWeatherStackView.heightAnchor.constraint(equalTo: horizontalScrollView.heightAnchor)
        ])
        
        [timelyWeatherInfoView1, timelyWeatherInfoView2, timelyWeatherInfoView3, timelyWeatherInfoView4, timelyWeatherInfoView5, timelyWeatherInfoView6, timelyWeatherInfoView7,timelyWeatherInfoView8, timelyWeatherInfoView9, timelyWeatherInfoView10, timelyWeatherInfoView11, timelyWeatherInfoView12].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            ($0.widthAnchor.constraint(equalToConstant: 65)).isActive = true
            ($0.heightAnchor.constraint(equalToConstant: 105)).isActive = true
            timelyWeatherStackView.addArrangedSubview($0)
        }
    }
    
    private func setBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "background_image1"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        view.insertSubview(backgroundImageView, at: 0)
    }
    
}

extension WeatherDetailedInfoVC: CustomBottomBarViewDelegate {
    
    func listButtonPressed(_ customBottomBarView: CustomBottomBarView) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
}
