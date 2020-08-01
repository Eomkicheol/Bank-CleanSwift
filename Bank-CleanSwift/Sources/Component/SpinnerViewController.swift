//
//  SpinnerViewController.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 01/08/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import UIKit

final class SpinnerViewController: UIViewController {
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.3)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
