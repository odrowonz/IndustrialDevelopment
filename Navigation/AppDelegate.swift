//
//  AppDelegate.swift
//  Navigation
//
//  Created by Andrey Antipov on 18.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print(type(of: self), #function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print(type(of: self), #function)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print(type(of: self), #function)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // 2020-12-17 04:21:29.838874+0300 Navigation copy[13417:5468445]
        // [BackgroundTask] Background Task 3 ("Called by Navigation copy,
        // from $s15Navigation_copy18FeedViewControllerC22registerBackgroundTaskyyF"),
        // was created over 30 seconds ago. In applications running in the background,
        // this creates a risk of termination.
        // Remember to call UIApplication.endBackgroundTask(_:)
        // for your task in a timely manner to avoid this.
        print(type(of: self), #function)
    }

    func application(_ app: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        print(type(of: self), #function)
        return true
    }

    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        print(type(of: self), #function)
        return true
    }
}
