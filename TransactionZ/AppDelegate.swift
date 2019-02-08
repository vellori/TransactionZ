//
//  AppDelegate.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // The testing target configuration has TESTING macro set, so we set a controller and system won't load main storyboard... meaning we get accurate unit testing coverage
        #if TESTING
        let controller = UIViewController()
        controller.view.backgroundColor = UIColor.white
        let label = UILabel()
        label.text = "TESTING"
        label.textColor = .red
        controller.view.addSubview(label)
        label.sizeToFit()
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        label.center = controller.view.center
        #endif
        return true
    }
    
}

