//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation
import Combine

class WeatherViewModel: WeatherViewModelProtocol {
    private var city: City
    private let mapper: WeatherViewModelMapper
    private let provider: WeahterProviderProtocol
    private let wireframe: WireframeProtocol
    
    @Published private(set) var dataSource: WeatherViewModelData = WeatherViewModelData.activityIndicator()
    var dataSourcePublished: Published<WeatherViewModelData> { _dataSource }
    var dataSourcePublisher: Published<WeatherViewModelData>.Publisher { $dataSource }
    
    private var cancellables = Set<AnyCancellable>()
    
    required init(city: City,
                  mapper: WeatherViewModelMapper,
                  provider: WeahterProviderProtocol,
                  wireframe: WireframeProtocol) {
        self.city = city
        self.mapper = mapper
        self.provider = provider
        self.wireframe = wireframe
    }
    
    // MARK: WeatherViewModelProtocol
    
    func navigateToCityList() {
        wireframe.didPressCityListButton()
    }
    
    func saveCity() throws {
        try provider.save(city: city)
    }
    
    func updateCity() throws {
        if provider.isSaved(city: city) {
            try provider.save(city: city)
        }
    }
    
    var isSaved: Bool {
        provider.isSaved(city: city)
    }

    func requestForecast() {
        dataSource = WeatherViewModelData.activityIndicator()
        
        provider.forecast(for: city)
            .map({
                self.city.temperature = MeasurementFormatter.string(from: $0.list.first?.main.temperature)
                return $0
            })
            .map(mapper.map(with:))
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
    
}
