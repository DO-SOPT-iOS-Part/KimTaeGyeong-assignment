//
//  CurrentWeatherService.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 11/13/23.
//

import Foundation

class CurrentWeatherService {
    
    static let shared = CurrentWeatherService()
    init() {}
    
    func makeRequest(cityName: String) -> URLRequest {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey!)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let header = ["Content-Type": "application/json"]
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
    
    func GetCurrentWeatherData(cityName: String) async throws -> CurrentWeatherDataModel {
        do {
            let request = self.makeRequest(cityName: cityName)
            let (data, response) = try await URLSession.shared.data(for: request)
            dump(request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.responseError
            }
            dump(response)
            guard let parseData = parseCurrentWeatherData(data: data)
            else {
                throw NetworkError.responseDecodingError
            }
            return parseData
        } catch {
            throw error
        }
        
    }
    
    
    private func parseCurrentWeatherData(data: Data) -> CurrentWeatherDataModel? {
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(CurrentWeatherDataModel.self, from: data)
            return result
        } catch {
            print(error)
            return nil
        }
    }
    
    private func configureHTTPError(errorCode: Int) -> Error {
        return NetworkError(rawValue: errorCode)
        ?? NetworkError.unknownError
    }
    
}

