//
//  WeatherInfoListData.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 11/6/23.
//

import Foundation

struct WeatherInfoListData: Equatable {
    let location: String
    let time: String
    let weather: String
    let temperature: Int
    let maxTemperature: Int
    let minTemperature: Int
    
    init(location: String, time: String, weather: String, temperature: Int, maxTemperature: Int, minTemperature: Int) {
        self.location = location
        self.time = time
        self.weather = weather
        self.temperature = temperature
        self.maxTemperature = maxTemperature
        self.minTemperature = minTemperature
    }
}

var weatherInfoListData: [WeatherInfoListData] = [
    .init(location: "서울", time: "05:00", weather: "흐림", temperature: 22, maxTemperature: 23, minTemperature: 20),
    .init(location: "분당구", time: "05:00", weather: "맑음", temperature: 20, maxTemperature: 24, minTemperature: 18),
    .init(location: "뉴욕", time: "05:00", weather: "맑음", temperature: 7, maxTemperature: 22, minTemperature: 17),
]
