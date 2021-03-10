//
//  CityListFooterView.swift
//  OpenWeather
//
//  Created by Ricardo Maqueda Martinez on 24/01/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import UIKit

protocol CityListFooterViewDelegate: AnyObject {
    func didPressMagnitudeButton()
    func didPressTWCButton()
    func didPressSearchButton()
}

final class CityListFooterView: UITableViewHeaderFooterView {
    @IBOutlet private weak var magnitudeButton: UIButton!
    @IBOutlet private weak var twcButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    
    weak var delegate: CityListFooterViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        contentView.backgroundColor = .background
        
        let twcImage = UIImage(named: "twc")?.withRenderingMode(.alwaysTemplate)
        twcButton.setImage(twcImage, for: .normal)
        twcButton.tintColor = .gray
        searchButton.tintColor = .foreground
        searchButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    func configure(for temperatureUnit: TemperatureUnit) {
        let title = TemperatureUnit.celsius.rawValue + " / " + TemperatureUnit.fahrenheit.rawValue
        let stringToColor = temperatureUnit.rawValue
        
        let range = (title as NSString).range(of: stringToColor)
        let mutableAttributedString = NSMutableAttributedString(string: title)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.foreground, range: range)

        magnitudeButton.setAttributedTitle(mutableAttributedString, for: .normal)
    }
    
    // MARK: Actions
    
    @IBAction func didPressMagnitudeButton(_ sender: Any) {
        delegate?.didPressMagnitudeButton()
    }
    
    @IBAction func didPressTWCButton(_ sender: Any) {
        delegate?.didPressTWCButton()
    }
    
    @IBAction func didPressSearchButton(_ sender: Any) {
        delegate?.didPressSearchButton()
    }
}
