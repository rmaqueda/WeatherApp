//
//  CityTableViewCell.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var mainText: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var temperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetCell()
        
        mainText.textColor = .white
        subTitle.textColor = .white
        temperature.textColor = .white
        backgroundColor = .black
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
    
    func configure(with city: City, dateFormatter: DateFormatter) {
        mainText.text = city.name
        
        dateFormatter.timeZone = city.timeZone
        subTitle.text = dateFormatter.string(from: Date())
        temperature.text = city.temperature
    }

}
