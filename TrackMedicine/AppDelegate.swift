//
//  AppDelegate.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 2/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        setRootViewController(rootViewControllerIdentifier: "ListNavigationController")
        return true
    }
    
    func setRootViewController(rootViewControllerIdentifier: String) {
        let storyboard = UIStoryboard(name: "Main",
        bundle: Bundle(for: TodayViewController.self))
        let controller = storyboard
            .instantiateViewController(withIdentifier: "TabBarController") as? UITabBarController
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
}

