//
//  UIViewController+Base.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 06.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import UIKit
import RNNotificationView

extension UIViewController {
    
    func showErrorWith(title: String, message: String) {
        
        let alertController = JHTAlertController(title: title, message: message, preferredStyle: .alert, iconImage: UIImage(named: "Alert Sad"))
        alertController.hasRoundedCorners = true
        alertController.dividerColor = UIColor.white
        
        //Заголовок
        let titleFont = UIFont(name: Fonts.Medium.rawValue, size: 17.0)
        let titleColor = UIColor.colorFrom(hex: "333333")
        alertController.titleFont = titleFont
        alertController.titleTextColor = titleColor
        alertController.titleViewBackgroundColor = UIColor.white
        
        //Текст
        let messageFont = UIFont(name: Fonts.Regular.rawValue, size: 15.0)
        let messageColor = UIColor.colorFrom(hex: "333333")
        alertController.messageFont = messageFont
        alertController.messageTextColor = messageColor
        alertController.alertBackgroundColor = UIColor.white
        
        //Кнопка
        let cancelText = NSLocalizedString("Alert.Button.Cancel", comment: "")
        let cancelAction = JHTAlertAction(title: cancelText, style: .cancel, bgColor: UIColor.colorFrom(hex: "ff9b00"), handler: nil)
        let buttonFont = UIFont(name: Fonts.Medium.rawValue, size: 17.0)!
        alertController.setButtonFontFor(.cancel, to: buttonFont)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showAlertWith(title: String, message: String, complition: @escaping () -> ()) {
        
        let aa = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancelActionButton = NSLocalizedString("Auth.Success.Close", comment: "")
        let cancelAction = UIAlertAction(title: cancelActionButton, style: .default, handler: {(alert: UIAlertAction) in
            
            complition()
        })
        
        aa.addAction(cancelAction)
        self.present(aa, animated: true, completion: nil)
    }
    
    func showNotificationErrorWith(title: String, message: String, duration: TimeInterval) {
        
        RNNotificationView.show(withImage: UIImage(named: "Notification Warning"), title: title, message: message, duration: duration, iconSize: CGSize(width: 22, height: 22), onTap: nil)
    }
    
    ///Проверка наличия соединения с интернетом
    func hasConnectivity() -> Bool {
        
        let reachability: Reachability = Reachability.forInternetConnection()
        let networkStatus: Int = reachability.currentReachabilityStatus().rawValue
        return networkStatus != 0
    }
}
