//
//  WeatherView.swift
//  WeatherIOS
//
//  Created by Cesar Hilario on 16/07/22.
//

import SwiftUI
import Combine

struct WeatherView: View {
    var weather: ResponseBody;
    @ObservedObject var favoriteManager: FavoriteManager;
    
    @State var isFavorite: Bool = false;
    @State var isToastShowing: Bool = false;
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(weather.name)
                            .bold().font(.title)
                        Button(action: {
                            isFavorite = !isFavorite;
                            isToastShowing = !isToastShowing;
                            
                            if(isFavorite) {
                                try? favoriteManager.add(id: weather.id, name: weather.name);
                            } else {
                                try? favoriteManager.remove(id: weather.id);
                            }
                        }) {
                            if (self.isFavorite) {
                                Image(systemName: "star.fill")
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(Color("yellow"))
                            } else {
                                Image(systemName: "star")
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                    
                }
                .padding(.top, 90)
                .frame(maxWidth: .infinity, alignment: .leading)
                
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
                    
                    
                    Image(getIllustrationByPartOfTheDay(partOfTheDay: getPartOfTheDay()))
                        .resizable()
                        .frame(width: 250, height: 250, alignment: .center)
                        .clipped()
                        .cornerRadius(125)
                    
                    Spacer()
                        .frame(height: 340)
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
                .padding(.horizontal, 40)
                .padding(.top, 30)
                .padding(.bottom, 100)
                .foregroundColor(Color(getColorByPartOfTheDay(partOfTheDay: getPartOfTheDay())))
                .background(.white)
                .cornerRadius(20, corners: [.topLeft, .topRight])
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(getColorByPartOfTheDay(partOfTheDay: getPartOfTheDay())))
        .preferredColorScheme(.dark)
        .toast(message: isFavorite ? "Added to favorites" : "Removed from favorites", isShowing: $isToastShowing, duration: 2.0)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(weather: previewWeather, favoriteManager: FavoriteManager())
    }
}
