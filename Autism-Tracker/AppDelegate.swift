//
//  AppDelegate.swift
//  Autism-Tracker
//
//  Created by Eric Wong on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit
import NeuraSDK
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Firebase
        FIRApp.configure()
        
        // Neura
        NeuraSDK.shared.appUID = "6313ad76be25b88a4c8afab56e15f3f24a13c4596f479da01e907d766f11bb1d"
        NeuraSDK.shared.appSecret = "3cf5101e7e5c7a805d7a6965de59ebb07eade562ecf0ca556247205405ffa4c7"
        
        // UI Navigation Bar
        UIApplication.shared.statusBarStyle = .lightContent
      
        UINavigationBar.appearance().barTintColor = UIColor.brandBlue
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UINavigationBar.appearance().isTranslucent = false
        
        return true
    }


}

