//
//  WeatherDetailedInfoVC.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/21/23.
//

import UIKit

class WeatherDetailedInfoVC: UIViewController {
    
    var location: String = ""
    var weather: String = ""
    var temperature: String = ""
    var maxTemperature: String = ""
    var minTemperature: String = ""
    
    private let customBottomBar = CustomBottomBarView()
    
    init(location: String, weather: String, temperature: String, maxTemperature: String, minTemperature: String) {
        self.location = location
        self.weather = weather
        self.temperature = temperature
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
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
        self.view.addSubview(customBottomBar)
        customBottomBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customBottomBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            customBottomBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            customBottomBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            customBottomBar.heightAnchor.constraint(equalToConstant: 80)
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
