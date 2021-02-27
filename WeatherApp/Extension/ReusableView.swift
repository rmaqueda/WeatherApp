//
//  ReusableView.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 27/02/2021.
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String { String(describing: self) }
}

protocol NibLoadableView {
    static var nibName: String { get }
}

extension NibLoadableView {
    static var nibName: String { String(describing: self) }
}

protocol ResettableView {
    func reset()
}
