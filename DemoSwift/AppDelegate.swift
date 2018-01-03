//
//  AppDelegate.swift
//  DemoSwift
//
//  Created by ZhiHua Shen on 2018/1/2.
//  Copyright © 2018年 ZhiHua Shen. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CAAnimationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let bounds = UIScreen.main.bounds
        self.window = UIWindow(frame: bounds)
        
        let vc = ViewController()
        vc.view.backgroundColor = UIColor.white
        
        window?.rootViewController = vc
        
        window?.makeKeyAndVisible()
        
        return true
    }

}

