//
//  AppDelegate.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var mainCoordinator: MainCoordinatorProtocol?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.mainCoordinator = Factory.mainCoordinator()
        self.mainCoordinator?.start()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.mainCoordinator?.navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}
