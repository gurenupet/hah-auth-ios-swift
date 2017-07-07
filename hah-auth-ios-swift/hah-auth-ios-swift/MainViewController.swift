//
//  ViewController.swift
//  hah-auth-ios-swift
//
//  Created by Anton Antonov on 06.07.17.
//  Copyright © 2017 KRIT. All rights reserved.
//

import UIKit
import Mixpanel

class MainViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Скрываем навигационную панель
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
}
