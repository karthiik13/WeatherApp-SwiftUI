//
//  WeatherManager.swift
//  SwiftUI-Weather
//
//  Created by Karthik Sudarsan on 26/08/24.
//

import Foundation
import SwiftUI

class WeatherManager {
    func fetchWeather(completion: @escaping (WeatherResponse?) -> Void) {
        let apiKey = "11629bb44acfa1a06e2146d28782fcc8"  
        let cityName = "Kochi"
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=metric"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        print(url)
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let weatherResponse = try? JSONDecoder().decode(WeatherResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(weatherResponse)
                }
            } else {
                completion(nil)
            }
        }.resume()
    }
}
