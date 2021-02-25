//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import UIKit
import Firebase

@main class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let firebaseOptions = FirebaseOptions.defaultOptions()!
        firebaseOptions.apiKey = ApplicationPreferences.googleAPIKey
        FirebaseApp.configure(options: firebaseOptions)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
}
