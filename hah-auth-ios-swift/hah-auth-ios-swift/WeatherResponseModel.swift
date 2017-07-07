//
//  WeatherResponseModel.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 07.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherResponseModel: Mappable {
    
    var weather: [Weather] = []
    var temperature: Temperature?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
 
        self.weather        <- map["weather"]
        self.temperature    <- map["main"]
    }
}
