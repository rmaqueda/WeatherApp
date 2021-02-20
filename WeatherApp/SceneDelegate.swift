//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    #if DEBUG
    var isUnitTest: Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    
    var UITestTag: String? {
        ProcessInfo.processInfo.environment["UITestTag"]
    }
    #endif
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
        
            #if DEBUG
            guard !isUnitTest else { return }
            if let tag = UITestTag {
                let wireframe = UITestsWireframe(window: window)
                wireframe.presentScreen(for: tag)
                return
            }
            #endif
                    
            AplicationPreferences.setupAppearance()
            
            let wireframe = Wireframe(window: window)
            wireframe.presentMainScreen()
        }
    }
    
}
