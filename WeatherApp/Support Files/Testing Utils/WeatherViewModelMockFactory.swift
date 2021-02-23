//
//  WeatherViewModelFactory.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import Foundation

#if DEBUG

struct WeatherViewModelMockFactory {
    private let UITestTag: UITestTag
    
    init(UITestTag: UITestTag) {
        self.UITestTag = UITestTag
    }

    func build() -> WeatherViewModelProtocol {
        let viewModel = WeatherViewModelMock()
        
        switch UITestTag {
        case .weatherHappyPath:
            viewModel.requestForecastSuccessResult = WeatherViewModelData.mockSuccess
        case .weatherErrorPath:
            viewModel.requestForecastErrorResult = WeatherViewModelData.mockError
        }
        
        return viewModel
    }
    
}

class WeatherViewModelMock: WeatherViewModelProtocol {
    @Published private(set) var dataSource: WeatherViewModelData = WeatherViewModelData.activityIndicator()
    var dataSourcePublished: Published<WeatherViewModelData> { _dataSource }
    var dataSourcePublisher: Published<WeatherViewModelData>.Publisher { $dataSource }

    var requestForecastSuccessResult: WeatherViewModelData?
    var requestForecastErrorResult: WeatherViewModelData?

    func requestForecast() {
        if let response = requestForecastSuccessResult {
            dataSource = response
        } else if let error = requestForecastErrorResult {
            dataSource = error
        }
    }

    func cacheSwitchDidChange(isEnable: Bool) {
        requestForecastSuccessResult = WeatherViewModelData.mockSuccess
    }
        
    var isSaved: Bool  = false
    
    func navigateToCityList() {
        
    }
    
    func saveCity() throws {
        
    }
    
    func updateCity() throws {
        
    }

}

#endif
