//
//  ViewController.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/20/23.
//

import UIKit

import SnapKit
import Then

class ViewController: UIViewController {
    
    var weatherInfoViewList = [WeatherInfoView(location: "서울", weather: "흐림", temperature: "25°", maxTemperature: "27°", minTemperature: "23°"), WeatherInfoView(location: "분당구", weather: "맑음", temperature: "25°", maxTemperature: "27°", minTemperature: "24°"), WeatherInfoView(location: "뉴욕", weather: "맑음", temperature: "23°", maxTemperature: "25°", minTemperature: "21°")]
    
    private lazy var rightBarButtonItem = UIBarButtonItem()
    private let locationSearchController = UISearchController()
    private let scrollView = UIScrollView()
    private var contentView = UIView()
    private var weatherInfoStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.setNavigation()
        self.setUI()
        self.setSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.searchController?.searchBar.isHidden = false
    }
    
}

extension ViewController {
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        rightBarButtonItem.do {
            $0.isHidden = false
            $0.image = UIImage(named: "ellipsis_image")
            $0.tintColor = .white
        }
        
        locationSearchController.do {
            $0.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "도시 또는 공항 검색", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6178889275, green: 0.6178889275, blue: 0.6178889275, alpha: 1)])
            $0.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.1353607476, green: 0.1353607476, blue: 0.1353607476, alpha: 1)
            $0.searchBar.searchTextField.textColor = .white
            $0.searchBar.tintColor = .white
            $0.searchBar.setValue("취소", forKey: "cancelButtonText")
            $0.hidesNavigationBarDuringPresentation = true
        }
        
        scrollView.do {
            $0.alwaysBounceVertical = true
            $0.showsVerticalScrollIndicator = false
        }
        
        weatherInfoStackView.do {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
            $0.spacing = 20
        }
    }
    
    private func setLayout() {
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        contentView.addSubview(weatherInfoStackView)
        
        weatherInfoStackView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).inset(7)
            $0.bottom.equalTo(contentView.snp.bottom)
            $0.leading.trailing.equalTo(contentView).inset(16)
        }
        
        weatherInfoViewList.forEach { view in
            view.delegate = self
            weatherInfoStackView.addArrangedSubview(view)
            view.snp.makeConstraints {
                $0.height.equalTo(120)
            }
        }
        
    }
    
    private func setNavigation() {
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.title = "날씨"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
