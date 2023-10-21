//
//  WeatherDetailedInfoVC.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/21/23.
//

import UIKit

class WeatherDetailedInfoVC: UIViewController {
    
    private let customBottomBar = CustomBottomBarView()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
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
        [customBottomBar,scrollView].forEach {
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
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: customBottomBar.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        
        [locationLabel, temperatureLabel, weatherLabel, maxtemperatureLabel, mintemperatureLabel].forEach {
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
