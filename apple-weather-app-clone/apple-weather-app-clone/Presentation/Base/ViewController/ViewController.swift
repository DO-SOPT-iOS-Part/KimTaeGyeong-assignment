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
    
    private lazy var rightBarButtonItem = UIBarButtonItem()
    private let locationSearchController = UISearchController()
    private let tableView = UITableView(frame: .zero, style: .plain)
    var searchWeatherInfoListData = weatherInfoListData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.setNavigation()
        self.setUI()
        self.setSearchController()
        Task {
            await fetchWeatherInfo()
        }
        self.setTableViewConfig()
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
        
        tableView.do {
            $0.backgroundColor = .black
            $0.separatorStyle = .none
            $0.showsVerticalScrollIndicator = false
        }
    }
    
    private func setLayout() {
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.view)
            $0.leading.trailing.equalToSuperview().inset(16)
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
    
    private func setTableViewConfig() {
        self.tableView.register(WeatherInfoTableViewCell.self,
                                forCellReuseIdentifier: WeatherInfoTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func fetchWeatherInfo() async {
        let cities = ["seoul", "daegu", "ulsan", "chuncheon", "jeju"]
        
        for city in cities {
            do {
                let currentWeather = try await CurrentWeatherService.shared.GetCurrentWeatherData(cityName: city)
                let weatherInfo = WeatherInfoListData(cityName: city, location: currentWeather.name, timezone: currentWeather.timezone, weather: currentWeather.weather[0].main, temperature: currentWeather.main.temp, maxTemperature: currentWeather.main.tempMax, minTemperature: currentWeather.main.tempMin)
                weatherInfoListData.append(weatherInfo)
                searchWeatherInfoListData = weatherInfoListData
            } catch {
                print(error)
            }
        }
        tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherDetailedInfoPageVC = WeatherDetailedInfoPageVC()
        weatherDetailedInfoPageVC.initialPage = weatherInfoListData.firstIndex(of: searchWeatherInfoListData[indexPath.row])!
        self.navigationController?.pushViewController(weatherDetailedInfoPageVC, animated: true)
    }
    
}


extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchWeatherInfoListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherInfoTableViewCell.identifier,
                                                       for: indexPath) as? WeatherInfoTableViewCell else {return UITableViewCell()}
        cell.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        cell.selectionStyle = .none
        cell.bindData(data: searchWeatherInfoListData[indexPath.row])
        return cell
    }
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText.isEmpty {
            searchWeatherInfoListData = weatherInfoListData
        } else {
            searchWeatherInfoListData = weatherInfoListData.filter { $0.location.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
}

