//
//  SplashView.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/25/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import SwiftUI

class SplashViewController: UIViewController {
   override func viewDidAppear(_ animated: Bool) {
         if(GlobalVariables.sharedManager.isLoggedIn())
         {   NotificationCenter.default.addObserver(
                            self,
                            selector: #selector(SplashViewController.reactToLoginResult(_:)),
                            name: NSNotification.Name(rawValue: GlobalVariables.actionSilentLoginCompleteNotificationName),
                            object: nil)
            GlobalVariables.sharedManager.silentLogin = true
            GlobalVariables.sharedManager.logInSilent()
            
         }else{
            loadHomeScreenDirectly(ctrlName: "LoginController")
    }
    }
    @objc func reactToLoginResult(_ note: Notification) {
                    OperationQueue.main.addOperation(){
                        self.loadHomeScreenDirectly(ctrlName: "MainTabBarController")
              }
       }
    func loadHomeScreenDirectly(ctrlName: String){
    //        performSegue(withIdentifier: "segueShowHomeScreen", sender: self)
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
             let mainTabBarController = storyBoard.instantiateViewController(identifier:  ctrlName)
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        }
}

 
