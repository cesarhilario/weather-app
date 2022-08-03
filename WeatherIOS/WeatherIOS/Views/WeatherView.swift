//
//  WeatherView.swift
//  WeatherIOS
//
//  Created by Cesar Hilario on 16/07/22.
//

import SwiftUI

struct WeatherView: View {
    var weather: ResponseBody
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(weather.name)
                        .bold().font(.title)
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                VStack {
                    HStack {
                        VStack(spacing: 20) {
                            AsyncImage(url: URL(string: "https://openweathermap.org/img/wn/\(weather.weather[0].icon)@2x.png"))
                            { image in image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 38)
                            } placeholder: {
                                ProgressView()
                            }
                            Text(weather.weather[0].main)
                                .fontWeight(.semibold)
                        }
                        .frame(width: 150, alignment: .leading)
                        
                        Spacer()
                        
                        Text(weather.main.feelsLike.roundDouble() + "º")
                            .font(.system(size: 100))
                            .fontWeight(.bold)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Image(getIllustrationByPartOfTheDay(partOfTheDay: getPartOfTheDay()))
                        .resizable()
                        .frame(width: 250, height: 250, alignment: .center)
                        .clipped()
                        .cornerRadius(125)
                    
                    Spacer()
                        .frame(height: 300)
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                Spacer()
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Weather now")
                        .bold().padding(.bottom)
                    HStack {
                        WeatherRow(logo: "thermometer", name: "Min temp", value: ( weather.main.tempMin.roundDouble() + "º" ))
                        Spacer()
                        WeatherRow(logo: "thermometer", name: "Max temp", value: ( weather.main.tempMax.roundDouble() + "º" ))
                    }
                    
                    HStack {
                        WeatherRow(logo: "wind", name: "Wind", value: ( weather.wind.speed.roundDouble() + "m/s" ))
                        Spacer()
                        WeatherRow(logo: "humidity", name: "Humidity", value: ( weather.main.tempMax.roundDouble() + "%" ))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .padding(.bottom, 20)
                .foregroundColor(Color(getColorByPartOfTheDay(partOfTheDay: getPartOfTheDay())))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(getColorByPartOfTheDay(partOfTheDay: getPartOfTheDay())))
        .preferredColorScheme(.dark)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather)
    }
}
