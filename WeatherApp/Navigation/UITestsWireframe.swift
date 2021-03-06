//
//  UITestsWireframe.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 20/02/2021.
//

import Foundation
import UIKit

#if DEBUG
struct UITestsWireframe {
    let window: UIWindow
    
    func presentScreen(for tag: String) {
        guard let uiTestTag = UITestTag(rawValue: tag) else {
            fatalError("Invalid UI testing tag.")
        }
        
        let viewModel =  WeatherViewModelMockFactory(uiTestTag: uiTestTag).build()
        let viewController = WeatherViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
#endif
