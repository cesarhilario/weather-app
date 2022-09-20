//
//  FavoritesView.swift
//  WeatherIOS
//
//  Created by Cesar Hilario on 18/09/22.
//

import SwiftUI


struct FavoritesView: View {
    
    @ObservedObject var favoriteManager: FavoriteManager;
    
    private func getColor() -> UIColor {
        return UIColor(Color(getColorByPartOfTheDay(partOfTheDay: getPartOfTheDay())))
    }
    
    
    var body: some View {
        List {
            Text("Favorites")
                .foregroundColor(.white)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .padding(.bottom, 15)
                .listRowBackground(Color.init(getColor()))
            
            
            ForEach(favoriteManager.getFavorites().sorted(by: <), id: \.key) { id, name in
                HStack() {
                    Text(name)
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    Spacer()
                    Button(action: {
                        try? favoriteManager.remove(id: id);
                    }) {
                        Image(systemName: "star.fill")
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color("yellow"))
                    }
                }
            }.listRowBackground(Color.init(getColor()))
        }
        .onAppear(
        ) {
            UITableView.appearance().separatorStyle = .none
            UITableViewCell.appearance().backgroundColor = getColor()
            UITableView.appearance().backgroundColor = getColor();
        }
        .listRowSeparator(.hidden)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var favoriteManager = FavoriteManager();
    
    static var previews: some View {
        FavoritesView(favoriteManager: favoriteManager)
    }
}
