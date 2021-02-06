//
//  LoginUIView.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 12/28/20.
//  Copyright © 2020 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtCode: UITextField!
    override func viewDidAppear(_ animated: Bool) {
        if(GlobalVariables.sharedManager.isLoggedIn())
        {
             loadHomeScreenDirectly()
        }
        GlobalVariables.sharedManager.silentLogin = false
        NotificationCenter.default.addObserver(
                  self,
                  selector: #selector(LoginViewController.reactToLoginResult(_:)),
                  name: NSNotification.Name(rawValue: GlobalVariables.actionLoginCompleteNotificationName),
                  object: nil)
    }
    
    
       @objc func reactToLoginResult(_ note: Notification) {
                 OperationQueue.main.addOperation(){
                    let response: ResponseEnvelope<User> = try! note.userInfo?["response"] as! ResponseEnvelope<User>
                    if(response.result == true){
                     //Do UI stuff here
                     self.loadHomeScreenDirectly()
                    }else{
                        self.alertWrongDataEntered()
                    }
           }
    }
 

    fileprivate func alertWrongDataEntered() {
        let alertMessage = UIAlertController(title: "Error", message:
            "Kindly enter your credentials before proceeding!", preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "Ok", style:         .default, handler:
            nil))
        self.present(alertMessage, animated: true, completion: nil)
    }
    
    @IBAction func click_btnLogin(_ sender: Any) {
        
        if(txtCode.text != ""){
                WebFunctions.Login(txtCode.text!, DeviceId: "0")
            } else{
            alertWrongDataEntered()
            }
    }
    
    func loadHomeScreenDirectly(){
//        performSegue(withIdentifier: "segueShowHomeScreen", sender: self)
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         let mainTabBarController = storyBoard.instantiateViewController(identifier:  "MainTabBarController")
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
    }
}
