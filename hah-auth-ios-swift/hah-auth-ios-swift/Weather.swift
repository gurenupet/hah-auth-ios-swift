//
//  Weather.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 07.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import Foundation
import ObjectMapper

class Weather: Mappable {

    var id:             Int?
    var main =          ""
    var description =   ""
    var icon =          ""
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        
        self.id             <- map["id"]
        self.main           <- map["main"]
        self.description    <- map["description"]
        self.icon           <- map["icon"]
    }
}
