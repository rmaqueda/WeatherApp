//
//  TemperatureCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit

class TemperatureCollectionViewCell: UICollectionViewCell, WeatherViewRepresentable, NibLoadableView, ReusableView {
    @IBOutlet weak private var temperature: UILabel!
    @IBOutlet weak private var highLowTemperature: UILabel!
   
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
            highLowTemperature.text = "H: \(temp.high) L: \(temp.low)"
        }
    }

}
