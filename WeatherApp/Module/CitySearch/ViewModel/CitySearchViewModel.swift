//
//  CitySearchViewModel.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 25/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation
import Combine

final class CitySearchViewModel: CitySearchViewModelProtocol {
    @Published private(set) var cities: [NSAttributedString] = []
    var citiesPublisher: Published<[NSAttributedString]>.Publisher { $cities }
    
    private let wireframe: WireframeProtocol
    private let provider: CitySearchProviderProtocol
    
    private var cancellables = Set<AnyCancellable>()
     
    required init(provider: CitySearchProviderProtocol, wireframe: WireframeProtocol) {
        self.wireframe = wireframe
        self.provider = provider
    }
        
    func searchCities(searchText: String) {
        provider.searchCities(searchText: searchText) { results in
            self.cities = results.map {
                ($0.title + " " + $0.subtitle).highlightedString(rangeValues: $0.titleHighlightRanges)
            }
        }
    }
    
    func didSelectCity(at index: Int) {
        provider.searchCity(at: index) { [weak self] city in
            self?.wireframe.presentForecast(for: city)
        }
    }
}
