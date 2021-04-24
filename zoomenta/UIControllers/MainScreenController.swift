//
//  MainScreenController.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 3/29/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit
class MainScreenController
: UITabBarController {
    

   var addButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       let  addButton =  UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logout))
        
        
        
        self.tabBarController?.navigationController?.navigationItem.rightBarButtonItem = addButton
    }
    @objc func logout(_ sender: UIBarButtonItem) {
    }
}
