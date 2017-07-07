//
//  UIColor+Creater.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 06.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import UIKit

extension UIColor {
    
    class func colorFrom(hex: String) -> UIColor {
        var rgbValue : UInt32 = 0
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        scanner.scanHexInt32(&rgbValue)
        
        return UIColor.colorFrom(red: Float((rgbValue & UInt32(0xFF0000)) >> 16),
                                 green: Float((rgbValue & UInt32(0xFF00)) >> 8),
                                 blue: Float(rgbValue & UInt32(0xFF)))
    }
    
    class func colorFrom(red: Float, green: Float, blue: Float) -> UIColor {
        
        return UIColor(colorLiteralRed: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}
