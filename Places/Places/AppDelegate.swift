//
//  AppDelegate.swift
//  Places
//
//  Created by Ranjeet Balkawade on 14/08/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Internal properties
    
    var window: UIWindow?
    var mainCoordinator: MainCoordinatorProtocol?
    
    //MARK: - Life cycle methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        mainCoordinator = Factory.mainCoordinator()
        mainCoordinator?.start()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainCoordinator?.navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}
