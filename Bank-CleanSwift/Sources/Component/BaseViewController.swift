//
//  BaseViewController.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let alertDismissButtonTitle = "alert.error.dismissButton"
    
    private(set) lazy var spinnerViewController = SpinnerViewController()
    
    func showSpinner() {
        self.addChild(spinnerViewController)
        spinnerViewController.view.frame = self.view.frame
        self.view.addSubview(spinnerViewController.view)
        spinnerViewController.didMove(toParent: self)
        self.view.isUserInteractionEnabled = false
    }
    
    func stopSpinner() {
        spinnerViewController.willMove(toParent: nil)
        spinnerViewController.view.removeFromSuperview()
        spinnerViewController.removeFromParent()
        self.view.isUserInteractionEnabled = true
    }
    
    func buildAlert(error: BankError, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: "alert.error.title".localized(), message: error.localizedDescription, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }
        return alert
    }
    
}
