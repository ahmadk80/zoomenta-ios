//
//  MyProfileController.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/26/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit

class MyProfileViewController: BaseUICtrl {
    
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var btnLogout: UIBarButtonItem!
    @IBOutlet weak var txtEmail: UITextField!
    
    
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
    @IBAction func btnLogout(_ sender: Any) {
        alertLogout(webView: self)
    }
    
    @IBAction func backTouch(_ sender: Any) {
        goHome()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
        
        super.fixTextBox(txt: txtFullName, disableTextBox: false)
        super.fixTextBox(txt: txtEmail, disableTextBox: false)
        txtEmail.text = GlobalVariables.sharedManager.myUser.email
        txtFullName.text = GlobalVariables.sharedManager.myUser.fullName
    }
    
    
    
}
