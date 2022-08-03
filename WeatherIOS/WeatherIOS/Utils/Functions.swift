//
//  Functions.swift
//  WeatherIOS
//
//  Created by Cesar Hilario on 02/08/22.
//

import Foundation

enum PartOfTheDay {
    case Sunrise;
    case Day;
    case Sunset;
    case Evening;
    case Night;
}

func getIllustrationByPartOfTheDay(partOfTheDay: PartOfTheDay) -> String {
    switch partOfTheDay {
    case .Sunrise:
        return "sunrise";
    case .Day:
        return "day";
    case .Sunset:
        return "sunset";
    case .Evening:
        return "evening";
    case .Night:
        return "night";
    }
}

func getColorByPartOfTheDay(partOfTheDay: PartOfTheDay) -> String {
    switch partOfTheDay {
    case .Sunrise:
        return "sunriseColor";
    case .Day:
        return "dayColor";
    case .Sunset:
        return "sunsetColor";
    case .Evening:
        return "eveningColor";
    case .Night:
        return "nightColor";
    }
}

func getPartOfTheDay() -> PartOfTheDay {
    let hour = Calendar.current.component(.hour, from: Date());
    
    if (hour >= 6 && hour < 11) {
        return PartOfTheDay.Sunrise;
    } else if(hour >= 11 && hour < 17) {
        return PartOfTheDay.Day;
    } else if (hour >= 17 && hour < 19) {
        return PartOfTheDay.Sunset;
    } else if (hour >= 19 && hour < 21) {
        return PartOfTheDay.Evening;
    } else if (hour >= 21 || hour >= 0 && hour < 5) {
        return PartOfTheDay.Night;
    } else {
        return PartOfTheDay.Day;
    }
}
