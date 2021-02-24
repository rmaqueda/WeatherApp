//
//  ApplicationPreferences.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import Foundation
import UIKit

class ApplicationPreferences {
    enum DataSourceType {
        case api
        case cache
    }
    
    static let defaultCity = "Munich"
    static let language = Locale.current.languageCode ?? "en"
    
    // swiftlint:disable force_cast
    static var APIKey: String = {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml
        let plistPath = Bundle.main.path(forResource: "Secrets", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath)!
        let dict = try? PropertyListSerialization.propertyList(from: plistXML,
                                                               options: .mutableContainersAndLeaves,
                                                               format: &propertyListFormat)
        let castDictionary = dict as! [String: String]
        
        return castDictionary["OpenWeatherAPIKey"]!
    }()
    // swiftlint:enable force_cast
    
    static let openWeatherAPIURL = URL(string: "https://api.openweathermap.org/data/2.5/")!
    static let openWeatherAPIUnit = "metric"
    
    static func setupAppearance() {
        UICollectionView.appearance().backgroundColor = UIColor(named: "BackgroundColor")
        
        UINavigationBar.appearance().tintColor = UIColor(named: "ForeGroundColor")
        UINavigationBar.appearance().barTintColor = UIColor(named: "BackgroundColor")
        UINavigationBar.appearance().backgroundColor = UIColor(named: "BackgroundColor")
        
        UIToolbar.appearance().barTintColor = UIColor(named: "BackgroundColor")
        UIToolbar.appearance().tintColor = UIColor(named: "ForeGroundColor")

        UIImageView.appearance().tintColor = UIColor(named: "ForeGroundColor")
        
        UIActivityIndicatorView.appearance().color = UIColor(named: "ForeGroundColor")
    }
}
