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
    
    init(date: String, weather: Int, temperature: Double) {
        self.time = convertDateToHour(dateString: date)!
        self.weather = convertWeather(weather: weather)
        self.temperatue = convertTemperature(temperature: temperature)
    }
}

func convertDateToHour(dateString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = "a h시"
        var formattedDate = dateFormatter.string(from: date)
        
        if let range = formattedDate.range(of: "AM") {
            formattedDate.replaceSubrange(range, with: "오전")
        } else if let range = formattedDate.range(of: "PM") {
            formattedDate.replaceSubrange(range, with: "오후")
        }
        
        return formattedDate
    } else {
        return nil
    }
}

func convertWeather(weather: Int) -> String {
    switch weather {
    case 200 ... 232:
        return "Thunderstorm"
    case 300 ... 321:
        return "Drizzle"
    case 500 ... 531:
        return "Rain"
    case 600 ... 622:
        return "Snow"
    case 701 ... 781:
        return "Atmosphere"
    case 800:
        return "Clear"
    case 900 ... 906:
        return "Clouds"
    case 951 ... 962:
        return "Additional"
    default:
        return "Clear"
    }
}
