//
//  LoginUIView.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 12/28/20.
//  Copyright © 2020 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: BaseUICtrl {
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtCode: UITextField!
    override func viewDidAppear(_ animated: Bool) {
        if(GlobalVariables.sharedManager.isLoggedIn())
        {
            self.loadMainScreen()
        }
        GlobalVariables.sharedManager.silentLogin = false
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(LoginViewController.reactToLoginResult(_:)),
            name: NSNotification.Name(rawValue: GlobalVariables.actionLoginCompleteNotificationName),
            object: nil)
        fixTextBox(txt: txtCode)
    }
    override func viewDidLoad() {
        roundAButton(btn: btnLogin)
    }
    
    @objc func reactToLoginResult(_ note: Notification) {
        OperationQueue.main.addOperation(){
            let response: ResponseEnvelope<User> = try! note.userInfo?["response"] as! ResponseEnvelope<User>
            if(response.result == true){
                //Do UI stuff here
                self.loadLogin()
            }else{
                self.removeSpinner()
                
                GlobalFunctions.alertError(webView: self, strError: "Please enter a valid OTP")
            }
        }
    }
    
    
 
    
    @IBAction func click_btnLogin(_ sender: Any) {
        
        if(txtCode.text != ""){
            showSpinner(onView: self.view)
            guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else {
                return
             }
           
            WebFunctions.Login(txtCode.text!, DeviceId: deviceID, controller: self)
        } else{
            GlobalFunctions.alertError(webView: self, strError: "Please enter OTP")
        }
    }
    
   
}
