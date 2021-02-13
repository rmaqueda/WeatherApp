//
//  SetDataSourceInteractor.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 07/02/2021.
//

import Foundation

class WeatherSetDataSourceInteractor: WeatherSetDataSourceInteractorProtocol {
    private let repository: WeatherRepositoryProtocol
    
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
        repository.setDataSourceType(.api)
    }
    
    // MARK: SetDataSourceInteractorProtocol
    
    func changeDataSource(isCacheEnabled: Bool) {
        repository.setDataSourceType(isCacheEnabled ? .cache : .api)
    }
    
}
