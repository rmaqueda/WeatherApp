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

            #if DEBUG
            if AppDelegate.isUnitTest {
                self.window = UIWindow(windowScene: windowScene)
                self.window?.makeKeyAndVisible()
                return
            }
            if let tag = AppDelegate.UITestTag {
                let wireframe = UITestsWireframe(window: aWindow)
                wireframe.presentScreen(for: tag)
                
                return
            }
            #endif
                    
            ApplicationPreferences.setupAppearance()
            
            let wireframe = Wireframe(window: aWindow)
            wireframe.presentMainScreen()
        }
    }
    
}
