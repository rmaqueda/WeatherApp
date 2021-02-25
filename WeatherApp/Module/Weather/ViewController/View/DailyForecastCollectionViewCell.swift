//
//  DailyForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit

class DailyForecastCollectionViewCell: UICollectionViewCell, WeatherViewRepresentable, NibLoadableView, ReusableView {
    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var imageView: UIImageView!
    @IBOutlet weak private var probabilityPrecipitation: UILabel!
    @IBOutlet weak private var subTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        resetCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        resetCell()
    }
    
    private func resetCell() {
        title.text = nil
        imageView.image = nil
        subTitle.text = nil
    }
    
    func configure(with section: WeatherViewSectionData, indexPath: IndexPath) {
        title.accessibilityIdentifier = "DailyForecastTitle_\(indexPath.row)"
        imageView.accessibilityIdentifier = "DailyForecastImageView_\(indexPath.row)"
        probabilityPrecipitation.accessibilityIdentifier = "DailyForecastPrecipitation_\(indexPath.row)"
        subTitle.accessibilityIdentifier = "DailyForecastSubtitle_\(indexPath.row)"
    
        if case let .dailyForecast(info) = section {
            let hourData = info[indexPath.row]
            
            title.text = hourData.title
            probabilityPrecipitation.text = hourData.probabilityPrecipitation
            subTitle.text = hourData.subTitle
            
            if let symbolName = hourData.icon?.SFSymbolName {
                imageView.image = UIImage(systemName: symbolName)
            }
        }
    }

}
