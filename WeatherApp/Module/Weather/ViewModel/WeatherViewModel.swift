//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//

import Foundation
import Combine

final class WeatherViewModel: WeatherViewModelProtocol {
    @Published private(set) var dataSource: WeatherViewModelData = WeatherViewModelData.activityIndicator()
    var dataSourcePublisher: Published<WeatherViewModelData>.Publisher { $dataSource }
    
    private var city: City
    private let provider: WeatherProviderProtocol
    private let mapper: WeatherViewModelMapper
    private let wireframe: WireframeProtocol
    private let userPreferences: UserPreferencesProtocol
    private var cancellables = Set<AnyCancellable>()
    
    required init(city: City,
                  provider: WeatherProviderProtocol,
                  mapper: WeatherViewModelMapper,
                  userPreferences: UserPreferencesProtocol,
                  wireframe: WireframeProtocol) {
        self.city = city
        self.mapper = mapper
        self.provider = provider
        self.wireframe = wireframe
        self.userPreferences = userPreferences
    }
    
    // MARK: WeatherViewModelProtocol
    
    var isSaved: Bool {
        provider.isSaved(city: city)
    }
    
    func saveCity() throws {
        try provider.save(city: city)
    }
    
    func updateCity() throws {
        try provider.save(city: city)
    }
    
    func requestForecast() {
        dataSource = WeatherViewModelData.activityIndicator()
        
        provider.forecast(for: city)
            .map({
                self.city.temperatureCelsius = $0.current.temp
                return $0
            })
            .map({ self.mapper.map(city: self.city, with: $0, temperatureUnit: self.userPreferences.temperatureUnit) })
            .sink(
                receiveCompletion: { [weak self] completion in
                    if case let .failure(error) = completion {
                        print(error)
                        self?.dataSource = WeatherViewModelData(error: error)
                    }
                },
                receiveValue: { [weak self] forecast in
                    
                    self?.dataSource = forecast
                })
            .store(in: &cancellables)
    }
    
    func didPressCityList() {
        wireframe.didPressCityListButton()
    }
    
    func didPressTWC() {
        wireframe.presentTWCWeb()
    }
    
}
