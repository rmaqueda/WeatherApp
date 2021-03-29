//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let aWindow = UIWindow(windowScene: windowScene)
            self.window = aWindow
            ApplicationPreferences.setupAppearance()
            
            // Avoid to load the application logic during unit test.
            // Make the unit tests fast and avoid unnecessary: network requests, load stacks, etc.
            #if DEBUG
            if AppDelegate.isUnitTest {
                self.window = UIWindow(windowScene: windowScene)
                self.window?.makeKeyAndVisible()
                
                return
            }
            
            // Get UI testing tag and load the app with specified mock data.
            if let tag = AppDelegate.uiTestTag {
                let wireframe = UITestsWireframe(window: aWindow)
                wireframe.presentScreen(for: tag)
                
                return
            }
            #endif
                    
            let userPreferences = UserPreferencesDisk()
            let wireframe = Wireframe(window: aWindow, userPreferences: userPreferences)
            wireframe.presentMainScreen()
        }
    }
    
}
