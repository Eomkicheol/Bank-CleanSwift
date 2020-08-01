//
//  AppDelegate.swift
//  Bank-CleanSwift
//
//  Created by Scott Takahashi on 31/07/20.
//  Copyright © 2020 Scott Takahashi. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        navigationController.isNavigationBarHidden = true
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        // Override point for customization after application launch.
        return true
    }


}

