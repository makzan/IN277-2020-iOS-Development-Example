//
//  Weather.swift
//  Current Weather
//
//  Created by Makzan on 23/12/2020.
//

import Foundation

struct WeatherService {
    public func fetchCurrentWeather( completion: ((Weather) -> Void)? = nil) {
        guard let url = URL(string: "https://dev.makzan.net/weather.json") else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONDecoder().decode(Weather.self, from: data)
                
                completion?(json)
                
            } catch let error{
                print("Fetch error.")
                print(error)
            }
        }.resume()
    }
}

struct Weather:Decodable {
    var date: String = ""
    var temperature: String = ""
    var humidity: String = ""
    var windSpeed: String = ""
    var windDescription: String = ""
    var today:String = ""
    var statusCode:String = ""
    var todayDescription = ""
    var tomorrowDescription = ""
}

struct Forecast:Decodable {
    var forecasts: [ForecastDay] = []
}

struct ForecastDay:Decodable {
    var date:String = ""
    var statusCode:String = ""
    var temperatureLow:String = ""
    var temperatureHigh:String = ""
    var description:String = ""
}

struct StatusCode {

    // https://xml.smg.gov.mo/#Status
    static let statusCodes = [
        "01": "sun.max.fill",
        "a1": "moon.fill",
        "02": "cloud.sun.fill",
        "a2": "cloud.moon.fill",
        "03": "cloud.fill",
        "04": "cloud.fill",
        "12": "cloud.rain.fill",
        "13": "cloud.rain.fill",
        "16": "cloud.heavyrain.fill",
        "17": "cloud.heavyrain.fill",
        "18": "cloud.bolt.rain.fill",
        "25": "cloud.bolt.fill",
        "27": "cloud.rain.fill",
        "28": "cloud.rain.fill",
        "c8": "cloud.moon.rain.fill",
        "29": "cloud.rain.fill",
        "c9": "cloud.moon.rain.fill",
    ]

    static func symbolFor(statusCode:String) -> String {
        return statusCodes[statusCode] ?? "sun.fill"
    }
}
