//
//  GlobalVariables.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/18/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit

class GlobalVariables: NSObject {
    
    // These are the properties you can store in your singleton
    internal var token: String = ""
    internal var userIsLoggedIn: Bool = false
    internal var WebServiceLink: String = "https://zoomenta.menta-lb.com/api/MobileAPI"
    //"http://93.187.35.11:4433/api/MobileAPI"
    internal var userFullName: String = ""
    internal var myMessage: String = ""
    internal var selectedDeliveryNote: Int = -1
    internal var selectedDeliveryNoteIndex: Int = -1
    internal var myUser: User!
    internal var silentLogin: Bool = false
    internal var deliverNotes: [DeliverNote]!
    internal var deliverNoteDetails: [DeliveryNoteDetails]!
    internal var filtered: [DeliveryNoteDetails]!
    
    internal var scannedValue: String!
    
    //internal var myNotifications: [AppNotification] = [AppNotification]()
    internal var notificationFetchingCount: Int = 0
    func isLoggedIn() -> Bool{
           return UserDefaults.standard.string(forKey: "otp") != nil &&   UserDefaults.standard.string(forKey: "otp") != ""
    }
    
    func logInSilent(sender: BaseUICtrl){
        guard let deviceID = UIDevice.current.identifierForVendor?.uuidString else {
                  return
               }
              
        WebFunctions.Login(UserDefaults.standard.string(forKey: "otp") ?? "", DeviceId: deviceID, controller: sender)
    }
    public static var loginOperation = "login"
    public static var deliveryNoteHistoryOperation = "DeliveryNoteHistory"
    public static var deliveryNoteDetailsOperation = "DeliveryNoteDetail"
    public static var scanDeliveryNoteOperation = "ScanDeliveryNote"
    
    
    public static var actionLoginCompleteNotificationName = "actionLoginCompleteNotificationName"
    
    
    
    
    
    public static var errorNotificationName = "errorNotificationName"
    public static var actionSilentLoginCompleteNotificationName = "actionSilentLoginCompleteNotificationName"
    public static var actionDeliveryNoteHistoryCompleteNotificationName = "actionDeliveryNoteHistoryCompleteNotificationName"
    public static var actionDeliveryNoteDetailsCompleteNotificationName = "actionDeliveryNoteDetailsCompleteNotificationName"
    public static var actionScanDeliveryNoteCompleteNotificationName = "actionScanDeliveryNoteCompleteNotificationName"
    
    // Here is how you would get to it without there being a global collision of variables.
    // , or in other words, it is a globally accessable parameter that is specific to the
    // class.
    class var sharedManager: GlobalVariables {
        struct Static {
            static let instance = GlobalVariables()
        }
        return Static.instance
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
