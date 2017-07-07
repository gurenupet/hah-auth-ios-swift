//
//  AppDelegate.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 06.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import UIKit
import Mixpanel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        configureMixpanel()
        configureNavigationBar()
        
        return true
    }
    
    //MARK: - Mixpanel
    func configureMixpanel() {
        
        let device = UIDevice.current.identifierForVendor?.uuidString
        
        Mixpanel.initialize(token: Parameters.MixpanelToken.rawValue)
        Mixpanel.mainInstance().identify(distinctId: device!)
    }
    
    //MARK: - Interface
    func configureNavigationBar() {

        //Title
        let titleFont = UIFont(name: Fonts.Medium.rawValue, size: 17.0)!
        let titleColor = UIColor.colorFrom(hex: "333333")
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName : titleFont, NSForegroundColorAttributeName : titleColor]
        
        //Кастомизация стрелки назад
        let backArrow = UIImage(named: "Navigation Bar Back Arrow")!
        UINavigationBar.appearance().backIndicatorImage = backArrow
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backArrow
        
        //Трюк для скрытия текста в кнопке назад
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.clear], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.clear], for: .highlighted)
    
        //Тень под панелью
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage(named: "Navigation Bar Shadow")
    }
}
