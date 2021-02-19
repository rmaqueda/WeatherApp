//
//  UIViewContoller.swift
//  WeatherApp
//
//  Created by Ricardo Maqueda Martinez on 04/02/2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentRetryAlert(withTitle title: String,
                           message: String?,
                           completionHandler: ((UIAlertAction) -> ())? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { action in
            completionHandler!(action)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)
        
        present(alertController, animated: true, completion: nil)
    }

}
