//
//  String.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 03/02/2021.
//  Copyright © 2021 Ricardo Maqueda Martinez. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
}

extension String {
    
    func highlightedString(rangeValues: [NSValue]) -> NSAttributedString {
        let attributtedString = NSMutableAttributedString(string: self,
                                                          attributes: [NSAttributedString.Key.foregroundColor: UIColor(hexString: "#4DFFFFFF")])
        
        let highligAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold),
                                 NSAttributedString.Key.foregroundColor: UIColor.white]
        let ranges = rangeValues.map { $0.rangeValue }
        ranges.forEach { (range) in
            attributtedString.addAttributes(highligAttributes, range: range)
        }
        
        return attributtedString
    }
    
}
