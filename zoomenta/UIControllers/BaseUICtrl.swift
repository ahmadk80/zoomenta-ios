//
//  BaseUICtrl.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 3/30/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit
class BaseUICtrl : UIViewController
{
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
    func fixTextBox(txt: UITextField, disableTextBox: Bool = true){
        let botomLine = CALayer()
        botomLine.frame = CGRect(x: 0.0, y: txt.frame.height - 1, width: txt.frame.width , height: 1.0)
        botomLine.backgroundColor = UIColor.gray.cgColor
        txt.borderStyle = UITextField.BorderStyle.none
        txt.layer.addSublayer(botomLine)
        txt.isEnabled = disableTextBox
        
    }
    func loadLogin(){
        loadHomeScreenDirectly(ctrlName: "LoginController")
    }
    func loadMainScreen(){
        loadHomeScreenDirectly(ctrlName: "MainTabBarController")
        
    }
    func roundAButton(btn: UIButton){
        btn.layer.cornerRadius = 5
        btn.clipsToBounds = true
    }
    func showSpinner(onView : UIView) {
           let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
           let ai = UIActivityIndicatorView.init(style: .whiteLarge)
           ai.startAnimating()
           ai.center = spinnerView.center
        
           DispatchQueue.main.async {
               spinnerView.addSubview(ai)
               onView.addSubview(spinnerView)
           }
           
           vSpinner = spinnerView
       }
       
       func removeSpinner() {
           DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
           }
       }
    
    var vSpinner : UIView?
    func loadHomeScreenDirectly(ctrlName: String){
    //        performSegue(withIdentifier: "segueShowHomeScreen", sender: self)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
             let mainTabBarController = storyBoard.instantiateViewController(identifier:  ctrlName)
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
    
    
    @objc func alertLogout(webView: UIViewController) {
        let alertMessage = UIAlertController(title: "Confirmation", message:
            "Are you sure you want to logout?", preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "No", style:         .default, handler:
            nil))
        
        alertMessage.addAction(UIAlertAction(title: "Yes", style:         .default, handler: {(ACTION) -> Void in
            GlobalVariables.sharedManager.token = ""
            GlobalVariables.sharedManager.myUser = nil
            //            let endcodedUser = try JSONEncoder().encode(item)
            UserDefaults.standard.set(nil, forKey: "otp")
            
            self.startLogin()
            
        }))
        webView.present(alertMessage, animated: true, completion: nil)
    }
    
    @objc func startLogin(){
        loadHomeScreenDirectly(ctrlName: "LoginController")
       // Switcher.updateRootVC()
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let mainTabBarController = storyBoard.instantiateViewController(identifier: "LoginController")
//        let appde = UIApplication.shared.delegate as! AppDelegate
//        mainTabBarController.show(<#T##vc: UIViewController##UIViewController#>, sender: <#T##Any?#>)
        
//        UIApplication.shared.delegate?.window??.rootViewController = mainTabBarController
//
//        navigationController?.show(mainTabBarController, sender: self)
        
        
        //             let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //        let mainTabBarController = storyBoard.instantiateInitialViewController()
        //        window?.rootViewController = mainTabBarController
        //        .show(mainTabBarController, sender: self)
    }
    
    func showAlert(withTitle title: String, message: String) {
      DispatchQueue.main.async {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
      }
    }
}
