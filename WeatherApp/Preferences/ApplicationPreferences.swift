//
//  ApplicationPreferences.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import Foundation
import UIKit

// swiftlint:disable force_cast
// The file has constants, so force unwrap is safe.
struct ApplicationPreferences {
    private static var secrets: [String: String] = {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        let plistPath = Bundle.main.path(forResource: "Secrets", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath)!
        let dict = try? PropertyListSerialization.propertyList(from: plistXML,
                                                               options: .mutableContainersAndLeaves,
                                                               format: &propertyListFormat)
        return dict as! [String: String]
    }()
    
    static let googleAPIKey: String? = secrets["GoogleAPIKey"]
    static let openWeatherAPIKey: String = secrets["OpenWeatherAPIKey"]!
    static let openWeatherAPIURL = URL(string: "https://api.openweathermap.org/data/2.5/")!
    static let openWeatherAPIUnit = "metric"
    static let openWeatherWebURL = URL(string: "https://www.weather.com")!
    
    static let language = Locale.current.languageCode ?? "en"
    
    static func setupAppearance() {
        UICollectionView.appearance().backgroundColor = .background
        
        UINavigationBar.appearance().tintColor = .foreground
        UINavigationBar.appearance().barTintColor = .background
        UINavigationBar.appearance().backgroundColor = .background
        
        UIToolbar.appearance().barTintColor = .background
        UIToolbar.appearance().tintColor = .foreground
        
        UISearchBar.appearance().keyboardAppearance = .dark
        UISearchBar.appearance().tintColor = .foreground

        UIImageView.appearance().tintColor = .foreground
        
        UITableView.appearance().backgroundColor = .background
        
        UIActivityIndicatorView.appearance().color = .foreground
    }
    
}
// swiftlint:enable force_cast
