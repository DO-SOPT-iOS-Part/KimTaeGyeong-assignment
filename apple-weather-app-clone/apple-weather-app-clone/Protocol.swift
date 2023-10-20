//
//  Protocol.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/21/23.
//

import Foundation

protocol WeatherInfoViewDelegate: AnyObject {
    func weatherInfoViewDidTap(_ weatherInfoView: WeatherInfoView)
}
