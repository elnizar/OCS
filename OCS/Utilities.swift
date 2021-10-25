//
//  Utilities.swift
//  OCS
//
//  Created by Nizar Elhraiech on 24/10/2021.
//

import Foundation
import UIKit
import MBProgressHUD
func showError(errorDescription: String?) {
    let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
    UIAlertController.showAlert(
        title: "",
        message: errorDescription,
        actions: [okAction]
    )
}

func showLoader(view: UIView) {
    DispatchQueue.main.async {
        let hub = MBProgressHUD.showAdded(to: view, animated: true)
        view.isUserInteractionEnabled = false
        hub.label.text = "Loading..."
    }
}
func hideLoader (view: UIView) {
    DispatchQueue.main.async {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            MBProgressHUD.hide(for: view, animated: true)
            view.isUserInteractionEnabled = true
        })
    }
    
}

