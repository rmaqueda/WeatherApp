//
//  ActivityIndicatorCollectionViewCell.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 05/02/2021.
//

import UIKit

final class ActivityIndicatorCollectionViewCell: UICollectionViewCell, WeatherViewRepresentable {
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    
    func configure(with section: WeatherViewSectionData, indexPath: IndexPath) {
        activityIndicator.startAnimating()
    }

}
