//
//  AppDelegate.swift
//  WorldCinema-ios
//
//  Created by Семён Алимпиев on 21.03.2023.
//

import IQKeyboardManagerSwift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appCoordinator = CoordinatorFactory().createAppCoordinator(navigationController: UINavigationController())
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        
        registerProviderFactories()
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = appCoordinator.navigationController
        
        appCoordinator.start()
        
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}
