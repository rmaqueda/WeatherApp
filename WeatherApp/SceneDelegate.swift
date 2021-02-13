//
//  SceneDelegate.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private let preferences = AplicationPreferences()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let viewController: UIViewController
            
            #if DEBUG
                // Avoid to start the app on unit testing
                if isUnitTesting() {
                    window = UIWindow(windowScene: windowScene)
                    window?.makeKeyAndVisible()
                    return
                }
                // Debug setup
                viewController = setupDebugWeatherModule()
            #else
                // Release setup
                viewController = setupWeatherModule()
            #endif
            
            let window = UIWindow(windowScene: windowScene)
            let navigationController = UINavigationController(rootViewController: viewController)
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
        
    }

    private func setupWeatherModule() -> WeatherViewController {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 5.0
        let session = URLSession(configuration: sessionConfig)
        
        let client = APIClient(preferences: preferences, session: session)
        let APIProvider = WeatherAPIProvider(APIClient: client)
        
        let localProvider = WeatherLocalProvider()
        let repository = WeatherRepository(APIProvider: APIProvider, localProvider: localProvider)
        let mapper = WeatherViewModelMapper()
        
        let requestForecastInteractor = WeatherRequestInteractor(preferences: preferences, repository: repository)
        let setDataSourceInteractor = WeatherSetDataSourceInteractor(repository: repository)
        
        let viewModel = WeatherViewModel(requestForecastInteractor: requestForecastInteractor,
                                         setDataSourceInteractor: setDataSourceInteractor,
                                         mapper: mapper)
        
        return WeatherViewController(viewModel: viewModel)
    }
        
    #if DEBUG
    private func setupDebugWeatherModule() -> WeatherViewController {
        // Check if UI testing is configured and setup module for UI testing
        if let environment = ProcessInfo.processInfo.environment["UITestTag"],
           let UITestTag = UITestTag(rawValue: environment) {
            let viewModel =  WeatherViewModelMockFactory(UITestTag: UITestTag).create()

            return WeatherViewController(viewModel: viewModel)
        }
        
        return setupWeatherModule()
    }
    
    private func isUnitTesting() -> Bool {
        ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
    }
    #endif
    
}
