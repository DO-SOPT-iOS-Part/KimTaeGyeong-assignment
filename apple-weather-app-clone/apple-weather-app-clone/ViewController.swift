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
        scrollView.showsVerticalScrollIndicator = false
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
    
    var weatherInfoViewList = [WeatherInfoView(location: "서울", weather: "흐림", temperature: "25°", maxTemperature: "27°", minTemperature: "23°"), WeatherInfoView(location: "분당구", weather: "맑음", temperature: "25°", maxTemperature: "27°", minTemperature: "24°"), WeatherInfoView(location: "뉴욕", weather: "맑음", temperature: "23°", maxTemperature: "25°", minTemperature: "21°")]
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.searchController?.searchBar.isHidden = false
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
            scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        [weatherInfoStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            weatherInfoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7),
            weatherInfoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            weatherInfoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            weatherInfoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
        
        weatherInfoViewList.forEach {
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
        self.locationSearchController.searchResultsUpdater = self
    }
    
}

extension ViewController: WeatherInfoViewDelegate {
    
    func weatherInfoViewTapped(_ weatherInfoView: WeatherInfoView) {
        let weatherDetailedInfoPageVC = WeatherDetailedInfoPageVC(weatherInfoViewList: weatherInfoViewList)
        weatherDetailedInfoPageVC.initialPage = weatherInfoViewList.firstIndex(of: weatherInfoView)!
        self.navigationController?.pushViewController(weatherDetailedInfoPageVC, animated: true)
    }
    
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() else {
            return
        }
        
        weatherInfoStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        if searchText.isEmpty {
            for weatherInfoView in weatherInfoViewList {
                weatherInfoStackView.addArrangedSubview(weatherInfoView)
            }
        } else {
            for weatherInfoView in weatherInfoViewList {
                let location = weatherInfoView.locationLabel.text!.lowercased()
                if location.contains(searchText) {
                    weatherInfoStackView.addArrangedSubview(weatherInfoView)
                }
            }
        }
    }
    
}
