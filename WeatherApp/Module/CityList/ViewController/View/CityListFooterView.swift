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

class CityListFooterView: UITableViewHeaderFooterView {
    @IBOutlet private weak var magnitudeButton: UIButton!
    @IBOutlet private weak var twcButton: UIButton!
    @IBOutlet private weak var searchButton: UIButton!
    
    weak var delegate: CityListFooterViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupView()
    }
    
    private func setupView() {
        contentView.backgroundColor = .black
        
        let twcImage = UIImage(named: "twc")?.withRenderingMode(.alwaysTemplate)
        twcButton.setImage(twcImage, for: .normal)
        twcButton.tintColor = .gray
        searchButton.tintColor = .white
        searchButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    func configure(for unitTemperature: UnitTemperature) {
        let title = "ºC / ºF"
        let stringToColor: String
        switch unitTemperature {
        case .celsius:
            stringToColor = "ºC"
        case .fahrenheit:
            stringToColor = "ºF"
        default:
            stringToColor = "ºC"
        }
        
        let range = (title as NSString).range(of: stringToColor)
        
        let mutableAttributedString = NSMutableAttributedString(string: title)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: range)

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
