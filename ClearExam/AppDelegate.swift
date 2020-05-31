//
//  AppDelegate.swift
//  ClearExam
//
//  Created by macgyver.s.villanda on 5/31/20.
//  Copyright © 2020 macgyver.s.villanda. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UserCache.shared.loadFavorites()
        window = UIWindow(frame: UIScreen.main.bounds)
        SearchCoordinator(window: window).start()
        window?.makeKeyAndVisible()
        return true
    }
}

