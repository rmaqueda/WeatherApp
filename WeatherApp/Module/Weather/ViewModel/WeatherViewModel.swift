//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation
import Combine

class WeatherViewModel: WeatherViewModelProtocol {
    private let requestForecastInteractor: WeatherRequestInteractorProtocol
    private let setDataSourceInteractor: WeatherSetDataSourceInteractorProtocol
    private let mapper: WeatherViewModelMapper
    
    @Published private(set) var dataSource: WeatherViewModelData = WeatherViewModelData.activityIndicator()
    var dataSourcePublished: Published<WeatherViewModelData> { _dataSource }
    var dataSourcePublisher: Published<WeatherViewModelData>.Publisher { $dataSource }
    
    private var cancellables = Set<AnyCancellable>()
    
    init(requestForecastInteractor: WeatherRequestInteractorProtocol,
         setDataSourceInteractor: WeatherSetDataSourceInteractorProtocol,
         mapper: WeatherViewModelMapper) {
        self.requestForecastInteractor = requestForecastInteractor
        self.setDataSourceInteractor = setDataSourceInteractor
        self.mapper = mapper
    }
    
    // MARK: WeatherViewModelProtocol
    
    func requestForecast(for city: String?) {
        dataSource = WeatherViewModelData.activityIndicator()
        
        requestForecastInteractor.requestForecast(for: city)
            .map(mapper.map(for:))
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        self?.dataSource = WeatherViewModelData(error: error)
                    }
                },
                receiveValue: { [weak self] forecast in
                    self?.dataSource = forecast
                })
            .store(in: &cancellables)
    }
    
    func cacheSwitchDidChange(isEnable: Bool) {
        setDataSourceInteractor.changeDataSource(isCacheEnabled: isEnable)
    }
    
}
