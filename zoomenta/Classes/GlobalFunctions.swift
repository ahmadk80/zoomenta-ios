//
//  GlobalFunctions.swift
//  zoomenta
//
//  Created by Ahmad Kaaki on 4/26/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//


import Foundation
import UIKit
class GlobalFunctions{
    
    class func alertError(webView: UIViewController, strError: String) {
        alertWrongDataEntered(webView: webView, strError: strError, strType: "Error")
    }
  
    
    class func alertInfo(webView: UIViewController, strError: String) {
        alertWrongDataEntered(webView: webView, strError: strError, strType: "Info")
    }
    class func alertWrongDataEntered(webView: UIViewController, strError: String, strType: String) {
        let alertMessage = UIAlertController(title: strType, message:
            strError, preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "Ok", style:         .default, handler:
            nil))
        webView.present(alertMessage, animated: true, completion: nil)
    }
    
    class func alertLogout(webView: UIViewController) {
        let alertMessage = UIAlertController(title: "Confirmation", message:
            "Are you sure you want to logout?", preferredStyle: .alert)
        alertMessage.addAction(UIAlertAction(title: "No", style:         .default, handler:
            nil))
        
        alertMessage.addAction(UIAlertAction(title: "Yes", style:         .default, handler: {(ACTION) -> Void in
             GlobalVariables.sharedManager.token = ""
                      GlobalVariables.sharedManager.myUser = nil
                      //            let endcodedUser = try JSONEncoder().encode(item)
                      UserDefaults.standard.set(nil, forKey: "otp")
            
            SceneDelegate.init().startLogin()
            
        }))
        webView.present(alertMessage, animated: true, completion: nil)
    }
    
    class func removeStringFromArray(_ MyToBeRemovedString:String, MyArray:[String]) -> Int
    {
        for (index, element) in MyArray.enumerated() {
            if (element == MyToBeRemovedString){
                return index
            }
            print("Item \(index): \(element)")
        }
        return -1
    }
    
    class func getFormattedDateWithDate(_ date: Date, WithDateFormat dateFormat: String) -> String {
        var dateFormatter = DateFormatter()
        // here we create NSDateFormatter object for change the Format of date..
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        // here set format which you want...
        dateFormatter.calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
        let loc = Locale(identifier: "en_US")
        dateFormatter.locale = loc
        let convertedString = dateFormatter.string(from: date)
        return convertedString
    }
    
    class func getUserDefaultsValueWithUserDefaultsKey(_ myKey: String) -> String {
                let prefs = UserDefaults.standard
        var myString = ""
        // getting an NSString
        if ((prefs.object(forKey: myKey)) != nil) {
            if (prefs.string(forKey: myKey)) != "" {
                myString = prefs.string(forKey: myKey)!
            }
            else {
                myString = ""
            }
        }else{
            myString = ""
        }
        return myString
    }
    
    class func setUserDefaultsValue(_ myValue: String, ForKey myKey: String) {
        let prefs = UserDefaults.standard
        // saving an NSString
        prefs.set(myValue, forKey: myKey)
        prefs.synchronize()
    }
    
    class func colorWithHexString (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: cString.index(cString.startIndex, offsetBy: 1))
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}
