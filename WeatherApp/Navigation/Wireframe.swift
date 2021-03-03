//
//  Wireframe.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 20/02/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit

// sourcery: autoSpy
protocol WireframeProtocol {
    var window: UIWindow { get }
    
    func presentMainScreen()
    func presentCityList()
    func presentCitySearch()
    func presentForecast(for city: City)
    func presentTWCWeb()
    func didPressCityListButton()
}

struct Wireframe: WireframeProtocol {
    let window: UIWindow
    private let apiClient: APIClient = {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 5.0
        let session = URLSession(configuration: sessionConfig)
        
        return APIClient(session: session)
    }()
    private let storage = CityDiskStorage()
    private let navigationController = UINavigationController()
    
    func presentMainScreen() {
        presentCityList()
        if storage.savedCities.isEmpty {
            presentCitySearch()
        }
    }
    
    func presentCityList() {
        let provider = CityListProvider(storage: storage)
        let viewModel = CityListViewModel(provider: provider, wireframe: self)
        let viewController = CityListViewController(viewModel: viewModel)

        navigationController.viewControllers = [viewController]
        navigationController.navigationBar.isHidden = true

        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func presentCitySearch() {
        let provider = CitySearchProvider(wireframe: self)
        let viewModel = CitySearchViewModel(provider: provider, wireframe: self)
        let viewController = CitySearchViewController(viewModel: viewModel)

        navigationController.present(viewController, animated: true)
    }
    
    func presentForecast(for city: City) {
        let provider = WeatherProvider(apiClient: apiClient, storage: storage)
        let viewModel = WeatherViewModel(city: city,
                                         mapper: WeatherViewModelMapper(),
                                         provider: provider,
                                         wireframe: self)
        let viewController = WeatherViewController(viewModel: viewModel)
        
        if viewModel.isSaved {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            let nav = UINavigationController(rootViewController: viewController)
            nav.modalPresentationStyle = .fullScreen
            navigationController.present(nav, animated: true)
        }
    }
    
    func presentTWCWeb() {
        UIApplication.shared.open(ApplicationPreferences.openWeatherWebURL)
    }
    
    func didPressCityListButton() {
        navigationController.navigationBar.isHidden = true
        navigationController.visibleViewController?.dismissOrPop()
    }
    
}
