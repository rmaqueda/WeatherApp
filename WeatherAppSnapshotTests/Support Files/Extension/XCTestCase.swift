//
//  XCTestCase.swift
//  WeatherAppSnapshotTests
//
//  Created by Ricardo Maqueda Martinez on 12/02/2021.
//

import Foundation
import XCTest
import UIKit
@testable import WeatherApp

extension XCTestCase {
    
    var activeScene: UIScene? {
        UIApplication.shared.connectedScenes.first { $0.activationState == .foregroundActive }
    }
    
    var window: UIWindow? {
        (activeScene?.delegate as? SceneDelegate)?.window
    }
    
}
