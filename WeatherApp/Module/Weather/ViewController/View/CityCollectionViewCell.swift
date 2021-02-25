//
//  CityCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell, WeatherViewRepresentable, NibLoadableView, ReusableView {
    @IBOutlet weak private var cityName: UILabel!
    @IBOutlet weak private var conditions: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityName.accessibilityIdentifier = "CityNameLabel"
        conditions.accessibilityIdentifier = "ConditionsLabel"
        
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
    
    func configure(with section: WeatherViewSectionData, indexPath: IndexPath) {
        if case let .city(info) = section {
            let city = info
            cityName.text = city.name
            conditions.text = city.currentWeatherText
        }
    }
    
}
