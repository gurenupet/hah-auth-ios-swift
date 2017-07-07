//
//  Constants.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 06.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import Foundation

enum Parameters: String {
    
    case MixpanelToken  = "407806200170018a45f587cac86ef5bb"
    case WheatherAPIKey = "71581e5ec25e34803c8ee87ffe803867"
}

enum Fonts: String {
    
    case Regular    = "SFUIText-Regular"
    case Medium     = "SFUIText-Medium"
}

enum URLs {
    
    static let base = "http://api.openweathermap.org/data/2.5"
    
    struct Authorization {
        
        static let weather = "/weather"
    }
}
