//
//  TimelyWeatherService.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 11/14/23.
//

import Foundation

class TimelyWeatherService {
    
    static let shared = TimelyWeatherService()
    private init() {}
    
    func makeRequest(location: String) -> URLRequest {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(location)&appid=\(apiKey!)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let header = ["Content-Type": "application/json"]
        header.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
    
    func GetTimelyWeatherData(location: String) async throws -> TimelyWeatherDataModel {
        do {
            let request = self.makeRequest(location: location)
            let (data, response) = try await URLSession.shared.data(for: request)
            dump(request)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.responseError
            }
            dump(response)
            guard let parseData = parseTimelyWeatherData(data: data)
            else {
                throw NetworkError.responseDecodingError
            }
            return parseData
        } catch {
            throw error
        }
        
    }
    
    
    private func parseTimelyWeatherData(data: Data) -> TimelyWeatherDataModel? {
        do {
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(TimelyWeatherDataModel.self, from: data)
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

