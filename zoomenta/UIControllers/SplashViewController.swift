//
//  SplashView.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/25/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import SwiftUI

class SplashViewController: BaseUICtrl
{
    
    var addButton: UIBarButtonItem!
    
    @IBOutlet weak var btnRefresh: UIButton!
    @objc func logout(_ sender: UIBarButtonItem) {
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SplashViewController.reactToError(_:)), name: NSNotification.Name(rawValue: GlobalVariables.errorNotificationName),
                                                                              object: nil)
        btnRefresh.isHidden = true
        addButton =  UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.tabBarController?.navigationController?.navigationItem.rightBarButtonItem = self.addButton
        if(GlobalVariables.sharedManager.isLoggedIn())
        {   NotificationCenter.default.addObserver(self, selector: #selector(SplashViewController.reactToLoginResult(_:)), name: NSNotification.Name(rawValue: GlobalVariables.actionSilentLoginCompleteNotificationName),
                                                   object: nil)
            GlobalVariables.sharedManager.silentLogin = true
            GlobalVariables.sharedManager.logInSilent(sender: self)
            
        }else{
            loadLogin()
        }
        showSpinner(onView: self.view)
      
    }
    @objc func reactToLoginResult(_ note: Notification) {
        OperationQueue.main.addOperation(){
            self.loadMainScreen()
        }
    }
    
    @IBAction func btnRefresh_click(_ sender: Any) {
        btnRefresh.isHidden = true
        GlobalVariables.sharedManager.logInSilent(sender: self)
        showSpinner(onView: self.view)
    }
    @objc func reactToError(_ note: Notification) {
        OperationQueue.main.addOperation(){
            self.btnRefresh.isHidden = false
        }
    }
}


