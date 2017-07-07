//
//  Temperature.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 07.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import Foundation
import ObjectMapper

class Temperature: Mappable {

    var temp: Double?
    var tempMin: Double?
    var tempMax: Double?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        self.temp       <- map["temp"]
        self.tempMin    <- map["temp_min"]
        self.tempMax    <- map["temp_max"]
    }
}
