//
//  ViewController.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/20/23.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.isHidden = false
        button.image = UIImage(named: "ellipsis_image")
        button.tintColor = .white
        return button
    }()
    
    private let locationSearchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "도시 또는 공항 검색", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6178889275, green: 0.6178889275, blue: 0.6178889275, alpha: 1)])
        searchController.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.1353607476, green: 0.1353607476, blue: 0.1353607476, alpha: 1)
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.tintColor = .white
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.hidesNavigationBarDuringPresentation = true
        return searchController
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private var contentView = UIView()
    
    private var weatherInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.title = "날씨"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.setLayout()
        self.setSearchController()
    }
    
}

extension ViewController {
    
    private func setLayout() {
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
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
        
        [weatherInfoStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            weatherInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            weatherInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            weatherInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            weatherInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        let seoulWeatherInfoView = WeatherInfoView(location: "서울", weather: "흐림", temperature: "25°", maxTemperature: "27°", minTemperature: "23°")
        let bundangWeatherInfoView = WeatherInfoView(location: "분당구", weather: "맑음", temperature: "25°", maxTemperature: "27°", minTemperature: "24°")
        let newyorkWeatherInfoView = WeatherInfoView(location: "뉴욕", weather: "맑음", temperature: "23°", maxTemperature: "25°", minTemperature: "21°")
        
        [seoulWeatherInfoView, bundangWeatherInfoView, newyorkWeatherInfoView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            ($0.heightAnchor.constraint(equalToConstant: 120)).isActive = true
            $0.delegate = self
            weatherInfoStackView.addArrangedSubview($0)
        }
    }
    
    private func setSearchController() {
        self.navigationItem.searchController = locationSearchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.locationSearchController.searchBar.searchTextField.textColor = .white
        self.locationSearchController.searchBar.searchTextField.leftView?.tintColor = #colorLiteral(red: 0.6178889275, green: 0.6178889275, blue: 0.6178889275, alpha: 1)
    }
    
}

extension ViewController: WeatherInfoViewDelegate {
    
    func weatherInfoViewTapped(_ weatherInfoView: WeatherInfoView) {
        guard let location = weatherInfoView.locationLabel.text,
              let weather = weatherInfoView.weatherLabel.text,
              let temperature = weatherInfoView.temperatureLabel.text,
              let maxTemperature = weatherInfoView.maxtemperatureLabel.text,
              let minTemperature = weatherInfoView.mintemperatureLabel.text else {
            return
        }
        
        let weatherDetailedInfoVC = WeatherDetailedInfoVC(location: location, weather: weather, temperature: temperature, maxTemperature: maxTemperature, minTemperature: minTemperature)
        
        self.navigationController?.pushViewController(weatherDetailedInfoVC, animated: true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
}
