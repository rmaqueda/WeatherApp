//
//  AplicationPreferences.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import Foundation
import UIKit

class AplicationPreferences {
    enum DataSourceType {
        case api
        case cache
    }
    
    let defaultCity = "Munich"
    let language = Locale.current.languageCode ?? "en"
    
    // swiftlint:disable force_cast
    var APIKey: String = {
        var propertyListForamt =  PropertyListSerialization.PropertyListFormat.xml
        let plistPath = Bundle.main.path(forResource: "Secrets", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath)!
        let dict = try? PropertyListSerialization.propertyList(from: plistXML,
                                                               options: .mutableContainersAndLeaves,
                                                               format: &propertyListForamt)
        let castDictionary = dict as! [String: String]
        
        return castDictionary["OpenWeatherAPIKey"]!
    }()
    // swiftlint:enable force_cast
    
    let openWeahterAPIURL = URL(string: "https://api.openweathermap.org/data/2.5/")!
    let openWeahterAPIUnit = "metric"
    
    init() {
        setupAppearance()
    }
    
    private func setupAppearance() {
        UICollectionView.appearance().backgroundColor = UIColor(named: "BackgroundColor")
        UINavigationBar.appearance().barTintColor = UIColor(named: "BackgroundColor")
        UINavigationBar.appearance().backgroundColor = UIColor(named: "BackgroundColor")
        UILabel.appearance().textColor = UIColor(named: "ForeGroundColor")
        UIImageView.appearance().tintColor = UIColor(named: "ForeGroundColor")
        UIActivityIndicatorView.appearance().color = UIColor(named: "ForeGroundColor")
    }
}
