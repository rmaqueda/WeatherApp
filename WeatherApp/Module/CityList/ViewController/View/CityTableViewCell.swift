//
//  CityTableViewCell.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit

final class CityTableViewCell: UITableViewCell {
    @IBOutlet private weak var mainText: UILabel!
    @IBOutlet private weak var subTitle: UILabel!
    @IBOutlet private weak var temperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetCell()
        
        mainText.textColor = .foreground
        subTitle.textColor = .foreground
        temperature.textColor = .foreground
        backgroundColor = .background
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetCell()
    }
    
    private func resetCell() {
        mainText.text = nil
        subTitle.text = nil
        temperature.text = nil
    }
    
    func configure(with city: City) {
        mainText.text = city.name
        
        let formatter = DateFormatter.time
        formatter.timeZone = city.timeZone
        subTitle.text = formatter.string(from: Date())
        
        temperature.text = city.temperatureString
    }

}
