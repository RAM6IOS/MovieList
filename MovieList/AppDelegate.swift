//
//  AppDelegate.swift
//  MovieList
//
//  Created by MACBOOK PRO on 29/6/2024.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: MoviesViewController())
        window?.makeKeyAndVisible()
        return true
    }
}

