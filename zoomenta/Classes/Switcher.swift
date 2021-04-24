//
//  Switcher.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 3/30/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit
class Switcher {
    
    static func updateRootVC(){
        
        let status = UserDefaults.standard.string(forKey: "otp")
        var rootVC : UIViewController?
       
            print(status)
        

        if(status == nil || status == ""){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginViewController
        }else{
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController")  as! MainScreenController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
