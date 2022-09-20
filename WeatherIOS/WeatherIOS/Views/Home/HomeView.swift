//
//  HomeView.swift
//  WeatherIOS
//
//  Created by Cesar Hilario on 18/09/22.
//

import SwiftUI

struct HomeView: View {
    @State var selection = 0;
    
    @State var weather: ResponseBody;
    
    @ObservedObject var favoriteManager: FavoriteManager = FavoriteManager()
    
    var body: some View {
        TabView(selection: $selection) {
            WeatherView(weather: weather, favoriteManager: favoriteManager)
                .tabItem {
                    Image(systemName: "sun.max.fill")
                    Text("Weather")
                }
                .refreshable {
                    
                }
                .tag(0)
            
            FavoritesView(favoriteManager: favoriteManager)
                .tabItem {
                    Image(systemName: "star")
                    Text("Favorites")
                }
                .tag(1)
        }
        .accentColor(.white)
        .onAppear() {
            UITabBar.appearance().backgroundColor = UIColor(Color(getColorByPartOfTheDay(partOfTheDay: getPartOfTheDay())))
            
            let image = UIImage.gradientImageWithBounds(
                bounds: CGRect( x: 0, y: 0, width: UIScreen.main.scale, height: 8),
                colors: [
                    UIColor.clear.cgColor,
                    UIColor.black.withAlphaComponent(0.3).cgColor
                ]
            )

            let appearance = UITabBarAppearance()
            appearance.shadowImage = image
            
            UITabBar.appearance().standardAppearance = appearance
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(weather: previewWeather)
    }
}
