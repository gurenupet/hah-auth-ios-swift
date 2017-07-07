//
//  UIButton+Base.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 06.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import UIKit

extension UIButton {
    
    ///Визуализация нажатия на кнопку
    override open var isHighlighted: Bool {
        
        didSet {
            
            self.alpha = (isHighlighted) ? 0.8 : 1.0
        }
    }
}
