//
//  WeatherModel.swift
//  SwiftUI-Weather
//
//  Created by Karthik Sudarsan on 26/08/24.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
