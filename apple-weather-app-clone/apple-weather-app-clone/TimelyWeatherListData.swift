//
//  TimelyWeatherListData.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 11/9/23.
//

import Foundation

struct TimelyWeatherListData {
    let time: String
    let weather: String
    let temperatue: Int
    
    init(time: String, weather: String, temperature: Int) {
        self.time = time
        self.weather = weather
        self.temperatue = temperature
    }
}

var timelyWeatherListData: [TimelyWeatherListData] = [
    .init(time: "지금", weather: "흐림", temperature: 9),
    .init(time: "오후 12시", weather: "폭우", temperature: 10),
    .init(time: "오후 1시", weather: "비", temperature: 11),
    .init(time: "오후 2시", weather: "다소 흐림", temperature: 12),
    .init(time: "오후 3시", weather: "흐림", temperature: 11),
    .init(time: "오후 4시", weather: "폭우", temperature: 10),
    .init(time: "오후 5시", weather: "흐림", temperature: 10),
    .init(time: "오후 6시", weather: "흐림", temperature: 10),
    .init(time: "오후 7시", weather: "흐림", temperature: 10),
    .init(time: "오후 8시", weather: "흐림", temperature: 9),
    .init(time: "오후 9시", weather: "흐림", temperature: 9),
    .init(time: "오후 10시", weather: "흐림", temperature: 9),
]
