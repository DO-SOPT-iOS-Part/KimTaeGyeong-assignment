//
//  WeatherDetailedInfoVC.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/21/23.
//

import UIKit

class WeatherDetailedInfoVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBackgroundImage()
    }
    
}

extension WeatherDetailedInfoVC {
    
    private func setBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "background_image1"))
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds
        view.insertSubview(backgroundImageView, at: 0)
    }
    
}
