//
//  String+Base.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 07.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import Foundation

extension String {
    
    var isEmailValid: Bool {
        
        let pattern = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.characters.count)) != nil
    }
 
    var isPasswordValid: Bool {
        
        //Если меньше 6 знаков
        if self.characters.count < 6 {
            
            return false
        }
        
        //Если нет цифр
        if self.rangeOfCharacter(from: .decimalDigits) == nil {
            
            return false
        }
        
        //Если нет прописной
        if self.rangeOfCharacter(from: .uppercaseLetters) == nil {
            
            return false
        }
        
        //Если нет строчной
        if self.rangeOfCharacter(from: .lowercaseLetters) == nil {
    
            return false
        }
        
        return true
    }
}
