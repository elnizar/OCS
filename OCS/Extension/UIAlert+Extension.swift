//
//  UIAlert+Extension.swift
//  OCS
//
//  Created by Nizar Elhraiech on 24/10/2021.
//

import Foundation
import UIKit
extension UIAlertController {
    static func showAlert(title: String?, message: String?, actions: [UIAlertAction], preferredStyle: UIAlertController.Style = .alert) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle
        )
        actions.forEach { alert.addAction($0) }
        DispatchQueue.main.async {
            UIApplication.shared.windows
                .filter({ $0.isKeyWindow }).first?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}

