//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Karthik Sudarsan on 21/08/24.
//

import SwiftUI

struct ContentView: View {
    
   //State Variable to toggle between day and night modes. A property wrapper type that can read and write a value managed by SwiftUI.

    @State private var isNight = false
    
    
    var body: some View {
        //ZStack A view that overlays its subviews, aligning them in both axes.
        ZStack {
            //Subview to set background color
            BackgroundView(isNight: $isNight)
            
            //A view that arranges its subviews in a vertical line.
            VStack {
                
                //SubView
                CityTextView(cityName: "Kochi, Kerala")
                
                //SubView that changes according to state variable isNight.
                MainWeatherStatusView(imageName: isNight ?  "moon.stars.fill": "cloud.sun.fill", temperature: isNight ?  24: 32)
               
                //HStack: A view that arranges its subviews in a horizontal line.
                HStack (spacing: 20){
                    WeatherDayView(dayOfWeek: "MON",
                                   imageName: "cloud.sun.fill",
                                   temperature: 30)
                    WeatherDayView(dayOfWeek: "TUE",
                                   imageName: "sun.max.fill",
                                   temperature: 32)
                    WeatherDayView(dayOfWeek: "WED",
                                   imageName: "cloud.fill",
                                   temperature: 27)
                    WeatherDayView(dayOfWeek: "THU",
                                   imageName: "cloud.drizzle.fill",
                                   temperature: 25)
                    WeatherDayView(dayOfWeek: "FRI",
                                   imageName: "cloud.bolt.fill",
                                   temperature: 23)
                    
                }
                //A flexible space that expands along the major axis of its containing stack layout, or on both axes if not contained in a stack.
                Spacer()
                
                //A control that initiates an action.
                Button{
                    isNight.toggle()
                } label: {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
                }
                Spacer()
            }
            
        }
        
       
    }
}

//Iterate designs quickly and preview your apps’ displays across different Apple devices.
#Preview {
    ContentView()
}

struct WeatherDayView : View {
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack{
            
            //A view that displays one or more lines of read-only text.
            Text(dayOfWeek )
                .font(.system(size: 14, weight: .medium, design: .default)) //Modifier that updates the font of the text.
                .foregroundColor(.white) //Modifier to set text color
                .padding() //Modifier to add padding around the text.
            
            //A view that displays an image.
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable() //Sets the mode by which SwiftUI resizes an image to fit its space.
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40) //Positions this view within an invisible frame with the specified size.

            Text("\(temperature)°")
                .font(.system(size: 16,weight: .medium))
                .foregroundColor(.white)
            
        }
    }
}

struct BackgroundView: View {
    //A property wrapper type that can read and write a value owned by a source of truth.
    @Binding var isNight: Bool
    
    var body: some View {
        //The gradient applies the color function along an axis, as defined by its start and end points. The gradient maps the unit space points into the bounding rectangle of each shape filled with the gradient.
        LinearGradient(gradient:Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : .lightBlue]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        //Expands the safe area of a view.
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

