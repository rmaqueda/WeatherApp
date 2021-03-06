//
//  CityCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import UIKit

final class CityCollectionViewCell: UICollectionViewCell, WeatherViewRepresentable {
    @IBOutlet private weak var cityName: UILabel!
    @IBOutlet private weak var conditions: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityName.accessibilityIdentifier = "CityNameLabel"
        conditions.accessibilityIdentifier = "ConditionsLabel"
        
        cityName.textColor = .foreground
        conditions.textColor = .foreground
        backgroundColor = .background
        
        resetCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetCell()
    }
    
    private func resetCell() {
        cityName.text = nil
        conditions.text = nil
    }
    
    func configure(with section: WeatherViewSection, indexPath: IndexPath) {
        if case let .city(info) = section {
            let city = info
            cityName.text = city.name
            conditions.text = city.currentWeatherText
        }
    }
    
}
