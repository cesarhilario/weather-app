//
//  ContentView.swift
//  WeatherIOS
//
//  Created by Cesar Hilario on 16/07/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var locationManager = LocationManager();
    @State var weather: ResponseBody?;
    
    var weatherManager = WeatherManager();
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    HomeView(weather: weather);
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.getCurrentWeather(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather \(error)")
                            }
                        }
                }
//                Text("Your coordinates are \(location.latitude), \(location.longitude)")
            } else {
                if locationManager.isLoading {
                    LoadingView();
                } else {
                    WelcomeView()
                        .environmentObject(locationManager);
                }
            }
            
        }
        .background(Color(red: 0.279, green: 0.335, blue: 0.718))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView();
    }
}
