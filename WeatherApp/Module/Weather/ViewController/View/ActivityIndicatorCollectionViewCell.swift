//
//  ActivityIndicatorCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import UIKit

class ActivityIndicatorCollectionViewCell: UICollectionViewCell, WeatherViewRepresentable, NibLoadableView, ReusableView {
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    func configure(with section: WeatherViewSectionData, indexPath: IndexPath) {
        activityIndicator.startAnimating()
    }

}
