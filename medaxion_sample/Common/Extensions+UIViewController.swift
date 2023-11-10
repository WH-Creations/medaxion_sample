//
//  Extensions+UIViewController.swift
//  medaxion_sample
//
//  Created by Casey West on 11/10/23.
//

import UIKit

extension UIViewController {
    
    // - Standard alert with dismiss via an 'OK' button
    func presentAlert(title: String, message: String, buttonTitle: String = "OK", handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: handler))
        self.present(alert, animated: true)
    }
    
}
