//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Liliane Bezerra Lima on 12/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let database = Database()
        database.clear()
        return true
    }
}

