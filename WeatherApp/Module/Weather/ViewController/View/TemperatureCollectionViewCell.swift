//
//  TemperatureCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit

class TemperatureCollectionViewCell: UICollectionViewCell, WeatherViewRepresentable {
    @IBOutlet private weak var temperature: UILabel!
    @IBOutlet private weak var highLowTemperature: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        temperature.accessibilityIdentifier = "TemperatureLabel"
        highLowTemperature.accessibilityIdentifier = "HighLowTemperatureLabel"
        
        resetCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetCell()
    }
    
    private func resetCell() {
        temperature.text = nil
        highLowTemperature.text = nil
    }
    
    func configure(with section: WeatherViewSectionData, indexPath: IndexPath) {
        if case let .temperature(info) = section {
            let temp = info
            temperature.text = temp.current
            highLowTemperature.text = temp.highLow
        }
    }

}
