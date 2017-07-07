//
//  UITextField+Base.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 06.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import UIKit

extension UITextField {
 
    func empty() -> Bool {
        
        return self.text?.trimmingCharacters(in: .whitespacesAndNewlines).characters.count == 0 ? true : false
    }
}
