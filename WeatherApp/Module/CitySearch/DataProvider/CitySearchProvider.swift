//
//  CitySearchProvider.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/03/2021.
//
// https://developer.apple.com/documentation/mapkit/searching_for_nearby_points_of_interest

import Foundation
import MapKit

class CitySearchProvider: NSObject, CitySearchProviderProtocol, MKLocalSearchCompleterDelegate {
    private var searchCompleter = MKLocalSearchCompleter()
    private var completionHandler: (([MKLocalSearchCompletion]) -> Void)?
    
    override init() {
        super.init()
        
        let filters = MKPointOfInterestFilter(including: [.airport])
        searchCompleter.pointOfInterestFilter = filters
        searchCompleter.resultTypes = [.address, .pointOfInterest]
        searchCompleter.delegate = self
    }
    
    func searchCities(searchText: String, completionHandler: @escaping ([MKLocalSearchCompletion]) -> Void) {
        self.completionHandler = completionHandler
        searchCompleter.queryFragment = searchText
    }
    
    // MARK: MKLocalSearchCompleter Delegate
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        completionHandler?(completer.results)
    }
    
    // MARK: MKLocalSearch Request
    
    func searchCity(at index: Int, completionHandler: @escaping (City) -> Void) {
        let search = searchCompleter.results[index]
        let searchRequest = MKLocalSearch.Request(completion: search)
        searchRequest.resultTypes = [.address, .pointOfInterest]
        
        MKLocalSearch(request: searchRequest).start { response, _ in
            if let item = response?.mapItems.first, let name = item.name {
                let coordinate = City.Coordinate(latitude: item.placemark.coordinate.latitude, longitude: item.placemark.coordinate.longitude)
                let city = City(name: name, coordinate: coordinate, timeZone: item.timeZone)
                completionHandler(city)
            }
        }
    }
}
