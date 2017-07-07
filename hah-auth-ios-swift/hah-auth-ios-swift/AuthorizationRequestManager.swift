//
//  AuthorizationRequestManager.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 07.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class AuthorizationRequestManager {
    
    ///Делаем авторизацию (но по заданию через получение информации о погоде). Получили — значит авторизовались :)
    class func doAuthWith(model: WeatherRequestModel, success: @escaping (_ response: WeatherResponseModel) -> (), failure: @escaping () -> ()) {
        
        let url = URLs.base + URLs.Authorization.weather
        let parameters = "?q=\(model.city)&appid=\(Parameters.WheatherAPIKey.rawValue)&lang=\(model.language)&units=\(model.units)"
        
        Alamofire.request(url + parameters, method: .get).responseJSON{(response: DataResponse<Any>) in
            
            guard let responseModel = Mapper<WeatherResponseModel>().map(JSONObject: response.result.value) else {
            
                failure()
                return
            }
            
            success(responseModel)
        }
    }
}
