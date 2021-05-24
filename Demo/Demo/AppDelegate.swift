//
//  AppDelegate.swift
//  Demo
//
//  Created by 张祥军 on 2021/5/17.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            self.window?.backgroundColor = UIColor.white
            self.window = UIWindow(frame: UIScreen.main.bounds)
            let home = EYBaseNavigationController.init(rootViewController: HomeViewController())
            self.window?.rootViewController = home
            window?.backgroundColor = UIColor.white
            window?.makeKeyAndVisible()
            return true
    }


}

