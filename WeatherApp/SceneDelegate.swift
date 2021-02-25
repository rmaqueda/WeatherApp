//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    #if DEBUG
    var UITestTag: String? {
        ProcessInfo.processInfo.environment["UITestTag"]
    }
    #endif
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
        
            #if DEBUG
            if let tag = UITestTag {
                let wireframe = UITestsWireframe(window: window)
                wireframe.presentScreen(for: tag)
                
                return
            }
            #endif
                    
            ApplicationPreferences.setupAppearance()
            
            let wireframe = Wireframe(window: window)
            wireframe.presentMainScreen()
        }
    }
    
}
