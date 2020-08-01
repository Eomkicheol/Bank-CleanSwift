//
//  BaseViewController.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
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
    
}
