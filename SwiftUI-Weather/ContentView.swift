//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Karthik Sudarsan on 21/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isNight = false
    @State private var temperature: Int = 0
    @State private var weatherIcon: String = "cloud.sun.fill"
    @State private var cityName: String = "Kochi, Kerala"
    private let weatherManager = WeatherManager()

    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            VStack {
                CityTextView(cityName: cityName)
                MainWeatherStatusView(imageName: weatherIcon, temperature: temperature)

                HStack(spacing: 20) {
                    WeatherDayView(dayOfWeek: "MON", imageName: "cloud.sun.fill", temperature: 74)
                    WeatherDayView(dayOfWeek: "TUE", imageName: "sun.max.fill", temperature: 88)
                    WeatherDayView(dayOfWeek: "WED", imageName: "wind.snow", temperature: 55)
                    WeatherDayView(dayOfWeek: "THU", imageName: "sunset.fill", temperature: 60)
                    WeatherDayView(dayOfWeek: "FRI", imageName: "snow", temperature: 25)
                }
                Spacer()
                Button {
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
                }
                Spacer()
            }
        }
        .on {
            weatherManager.fetchWeather { weatherResponse in
                print(weatherResponse)
                if let weatherResponse = weatherResponse {
                    self.temperature = Int(weatherResponse.main.temp)
                    self.weatherIcon =  mapWeatherIcon(iconCode: weatherResponse.weather.first?.icon ?? "sun.fill")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

struct WeatherDayView : View {
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack{
            Text(dayOfWeek )
                .font(.system(size: 14, weight: .medium, design: .default))
                .foregroundColor(.white)
                .padding()
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 16,weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}

struct BackgroundView: View {
    
    var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient:Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
}

struct CityTextView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
            .font(.system(size: 32,weight: .medium,design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    
    var imageName: String
    var temperature: Int

    
    var body: some View {
        VStack (spacing: 10){
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180,height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70,weight: .medium))
                .foregroundColor(.white)
            
        }
        .padding(.bottom, 40)
    }
}
func mapWeatherIcon(iconCode: String) -> String {
    switch iconCode {
    case "01d": // Clear sky (day)
        return "sun.max.fill"
    case "01n": // Clear sky (night)
        return "moon.stars.fill"
    case "02d": // Few clouds (day)
        return "cloud.sun.fill"
    case "02n": // Few clouds (night)
        return "cloud.moon.fill"
    case "03d", "03n": // Scattered clouds (day/night)
        return "cloud.fill"
    case "04d", "04n": // Broken clouds (day/night)
        return "smoke.fill"
    case "09d", "09n": // Shower rain (day/night)
        return "cloud.drizzle.fill"
    case "10d": // Rain (day)
        return "cloud.sun.rain.fill"
    case "10n": // Rain (night)
        return "cloud.moon.rain.fill"
    case "11d", "11n": // Thunderstorm (day/night)
        return "cloud.bolt.fill"
    case "13d", "13n": // Snow (day/night)
        return "snow"
    case "50d", "50n": // Mist (day/night)
        return "cloud.fog.fill"
    default: // Default icon
        return "cloud.sun.fill"
    }
}

