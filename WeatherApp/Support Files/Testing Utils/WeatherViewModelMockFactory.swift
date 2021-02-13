//
//  WeatherViewModelFactory.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import Foundation

#if DEBUG

class WeatherViewModelMockFactory {
    private let UITestTag: UITestTag
    
    init(UITestTag: UITestTag) {
        self.UITestTag = UITestTag
    }

    func create() -> WeatherViewModelProtocol {
        let viewModel = WeatherViewModelMock()
        
        switch UITestTag {
        case .weatherHappyPath:
            viewModel.responseSuccess = WeatherViewModelData.mockSuccess
        case .weatherErrorPath:
            viewModel.responseError = WeatherViewModelData.mockError
        }
        
        return viewModel
    }
    
}

class WeatherViewModelMock: WeatherViewModelProtocol {
    @Published private(set) var dataSource: WeatherViewModelData = WeatherViewModelData.activityIndicator()
    var dataSourcePublished: Published<WeatherViewModelData> { _dataSource }
    var dataSourcePublisher: Published<WeatherViewModelData>.Publisher { $dataSource }
    
    var responseSuccess: WeatherViewModelData?
    var responseError: WeatherViewModelData?
    
    func requestForecast(for city: String?) {
        if let response = responseSuccess {
            dataSource = response
        } else if let error = responseError {
            dataSource = error
        }
    }
    
    func cacheSwitchDidChange(isEnable: Bool) {
        responseSuccess = WeatherViewModelData.mockMadrid
    }
    
}

#endif
