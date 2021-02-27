//
//  WeatherViewModelFactory.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 06/02/2021.
//

import Foundation

#if DEBUG

struct WeatherViewModelMockFactory {
    private let uiTestTag: UITestTag
    
    init(uiTestTag: UITestTag) {
        self.uiTestTag = uiTestTag
    }

    func build() -> WeatherViewModelProtocol {
        let viewModel = WeatherViewModelMock()
        
        switch uiTestTag {
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
    
    func didPressCityList() {
        // Intentionally unimplemented
    }
    
    func saveCity() throws {
        // Intentionally unimplemented
    }
    
    func updateCity() throws {
        // Intentionally unimplemented
    }
    
    func didPressTWC() {
        // Intentionally unimplemented
    }

}

#endif
