//
//  FavoriteManager.swift
//  WeatherIOS
//
//  Created by Cesar Hilario on 18/09/22.
//

import Foundation

enum FavoriteManagerErrors: Error {
    case invalid_parameter(String);
    case notBeEmpty(String);
}

class FavoriteManager: ObservableObject {
    @Published var favoriteList: Dictionary<Int, String> = [:];
    
    public func add(id: Int, name: String) throws -> Void {
        if (!id.isMultiple(of: 1)) {
            throw FavoriteManagerErrors.invalid_parameter("Id should be a valid number.");
        }
        
        if (name.isEmpty) {
            throw FavoriteManagerErrors.notBeEmpty("Name not should be empty.");
        }
        
        if (self.favoriteAlreadyExists(id: id)) {
            print("Already exists");
            return;
        } else {
            favoriteList[id] = name;
        }
    }
    
    public func remove(id: Int) throws -> Void {
        if(!id.isMultiple(of: 1)) {
            throw FavoriteManagerErrors.invalid_parameter("Id should be a valid number");
        }
        
        if(self.favoriteAlreadyExists(id: id)) {
            favoriteList[id] = nil;
        }
    }
    
    public func getFavorites() -> Dictionary<Int, String> {
        return favoriteList;
    }
    
    public func count() -> Int {
        return favoriteList.count;
    }
    
    public func favoriteAlreadyExists(id: Int) -> Bool {
        if(favoriteList[id] != nil) {
            return true;
        } else {
            return false;
        }
    }
}

