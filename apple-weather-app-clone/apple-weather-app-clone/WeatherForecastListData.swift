//
//  WeatherForecastListData.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 11/5/23.
//

import Foundation

struct WeatherForecastListData {
    let day: String
    let weather: String
    let minTemperature: Int
    let image: String
    let maxTemperature: Int
    let rainGauge: Int
    
    init(day: String, weather: String, minTemperature: Int, image: String, maxTemperature: Int, rainGauge: Int = 0) {
        self.day = day
        self.weather = weather
        self.minTemperature = minTemperature
        self.image = image
        self.maxTemperature = maxTemperature
        self.rainGauge = rainGauge
    }
}

var weatherForecastListData: [WeatherForecastListData] = [
    .init(day: "오늘", weather: "맑음", minTemperature: 15, image: "temperature_bar_image1", maxTemperature: 29),
    .init(day: "월", weather: "비", minTemperature: 15, image: "temperature_bar_image2", maxTemperature: 29, rainGauge: 40),
    .init(day: "화", weather: "흐림", minTemperature: 15, image: "temperature_bar_image3", maxTemperature: 29),
    .init(day: "수", weather: "비", minTemperature: 15, image: "temperature_bar_image4", maxTemperature: 29, rainGauge: 30),
    .init(day: "목", weather: "맑음", minTemperature: 15, image: "temperature_bar_image5", maxTemperature: 29),
    .init(day: "금", weather: "비", minTemperature: 15, image: "temperature_bar_image6", maxTemperature: 29, rainGauge: 20),
    .init(day: "토", weather: "흐림", minTemperature: 15, image: "temperature_bar_image7", maxTemperature: 29),
    .init(day: "일", weather: "비", minTemperature: 15, image: "temperature_bar_image8", maxTemperature: 29, rainGauge: 50),
    .init(day: "월", weather: "맑음", minTemperature: 15, image: "temperature_bar_image9", maxTemperature: 29),
    .init(day: "화", weather: "비", minTemperature: 15, image: "temperature_bar_image10", maxTemperature: 29, rainGauge: 70),
]
