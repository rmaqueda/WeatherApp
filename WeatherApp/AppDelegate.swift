//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import UIKit
import Firebase

@main class AppDelegate: UIResponder, UIApplicationDelegate {
    #if DEBUG
    static let isUnitTest: Bool = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    static let uiTestTag: String? = ProcessInfo.processInfo.environment[uiTestEnvironmentKey]
    #endif

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        #if DEBUG
        guard !AppDelegate.isUnitTest else {
            return true
        }
        #endif
        
        if let googleAPIKey = ApplicationPreferences.googleAPIKey, !googleAPIKey.contains("Enter") {
            let firebaseOptions = FirebaseOptions.defaultOptions()!
            firebaseOptions.apiKey = googleAPIKey
            FirebaseApp.configure(options: firebaseOptions)
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
}
