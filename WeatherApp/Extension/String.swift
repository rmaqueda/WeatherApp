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
        prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
}

extension String {
    
    func highlightedString(rangeValues: [NSValue]) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self,
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.unSelected])
        
        let highlightAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .bold),
                                   NSAttributedString.Key.foregroundColor: UIColor.foreground]
        let ranges = rangeValues.map { $0.rangeValue }
        ranges.forEach { (range) in
            attributedString.addAttributes(highlightAttributes, range: range)
        }
        
        return attributedString
    }
    
}
