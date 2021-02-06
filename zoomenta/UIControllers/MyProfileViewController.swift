//
//  MyProfileController.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/26/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit

class MyProfileViewController: UIViewController {
    
    @IBOutlet weak var txtFullName: UITextField!
    
    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        fixTextBox(txt: txtFullName)
        fixTextBox(txt: txtEmail)
        txtEmail.text = GlobalVariables.sharedManager.myUser.email
        txtFullName.text = GlobalVariables.sharedManager.myUser.fullName
    }
    func fixTextBox(txt: UITextField){
        let botomLine = CALayer()
        botomLine.frame = CGRect(x: 0.0, y: txt.frame.height - 1, width: txt.frame.width, height: 1.0)
        botomLine.backgroundColor = UIColor.gray.cgColor
        txt.borderStyle = UITextField.BorderStyle.none
        txt.layer.addSublayer(botomLine)
        txt.isEnabled = false
        
    }
}
