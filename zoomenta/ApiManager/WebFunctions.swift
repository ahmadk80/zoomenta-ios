//
//  WebFunctions.swift
//  Aman365iOSApp
//
//  Created by Mohamad Sakakini on 11/22/20.
//  Copyright © 2020 Mohamad Sakakini. All rights reserved.
//

import Foundation
import UIKit
//import ARSLineProgress


class WebFunctions {
    class func Login(_ ActivationCode:String, DeviceId:String)
    {
        
        let myWebFunctions: WebFunctions = WebFunctions()
        myWebFunctions.otp = ActivationCode
        let myParameters: String = "{\"otp\":\"\(ActivationCode)\",\"deviceId\":\"\(DeviceId)\"}"
        myWebFunctions.SendPOSTRequestWithOperation(GlobalVariables.loginOperation, AndParameters: myParameters, AndLoaderText: "Please Wait", AndCallBackKey: GlobalVariables.loginOperation, AndRequestType: "POST", AndShowLoader: true)
    }
    internal var otp: String = ""
    
    class func GetDeliveryNoteHistory(from: Date,to: Date)
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let strFrom = dateFormatter.string(from: from)
        let strTo = dateFormatter.string(from: to)
        
        let myWebFunctions: WebFunctions = WebFunctions()
        let myParameters: String = "{\"From\": \"\(strFrom)\", \"To\":\"\(strTo)\"}"
        myWebFunctions.SendPOSTRequestWithOperation(GlobalVariables.deliveryNoteHistoryOperation, AndParameters: myParameters, AndLoaderText: "", AndCallBackKey: GlobalVariables.deliveryNoteHistoryOperation, AndRequestType: "POST", AndShowLoader: true)
    }
    class func GetDeliveryNoteDetails(deliveryNoteId: Int){
        let myWebFunctions: WebFunctions = WebFunctions()
        let myParameters: String = "{\"deliveryNoteId\":\"\(deliveryNoteId)\"}"
        myWebFunctions.SendPOSTRequestWithOperation(GlobalVariables.deliveryNoteDetailsOperation, AndParameters: myParameters, AndLoaderText: "", AndCallBackKey: GlobalVariables.deliveryNoteDetailsOperation, AndRequestType: "POST", AndShowLoader: true)
    }
    class func SendScannedDeliveryNote(code: String){
        let myWebFunctions: WebFunctions = WebFunctions()
        let myParameters: String = "{\"code\":\"\(code)\"}"
        myWebFunctions.SendPOSTRequestWithOperation(GlobalVariables.scanDeliveryNoteOperation, AndParameters: myParameters, AndLoaderText: "", AndCallBackKey: GlobalVariables.scanDeliveryNoteOperation, AndRequestType: "POST", AndShowLoader: true)
    }
    
    
    
    func fetchedDataLogin(_ data: Data){
        var item: User  = User()
        let response: ResponseEnvelope<User>
        
        do {
            response = try! JSONDecoder().decode(ResponseEnvelope<User>.self, from: data)
            item = response.data ?? User()
            let Token:String = item.token ?? ""
            GlobalVariables.sharedManager.token = Token
            GlobalVariables.sharedManager.myUser = item
            //            let endcodedUser = try JSONEncoder().encode(item)
            UserDefaults.standard.set(otp, forKey: "otp")
        } catch {
            print(error)
        }
        
        if(GlobalVariables.sharedManager.silentLogin){
            NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalVariables.actionSilentLoginCompleteNotificationName), object: nil, userInfo: ["response": response])
        }else{
            NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalVariables.actionLoginCompleteNotificationName), object: nil, userInfo: ["response": response])
        }
        
    }
    
    
    
    
    
    func fetchDeliveryNoteData(_ data: Data){
        
        var items = [DeliverNote]()
        let response: ResponseEnvelope<[DeliverNote]>
        
        do {
            response = try! JSONDecoder().decode(ResponseEnvelope<[DeliverNote]>.self, from: data)
            items = ((response.data ?? nil)!)
            GlobalVariables.sharedManager.deliverNotes = items
            //                    for myItem in response.data ?? <#default value#> {
            //                                  let item:DeliverNote = DeliverNote()
            //
            //                                  // Parse JSON data
            //                                  item.deliveryNoteId = ((myItem as! NSDictionary)["deliveryNoteId"] as? Int)!
            //                                  item.name = ((myItem as! NSDictionary)["name"] as? String)!
            //                                  item.scanningDate = ((myItem as! NSDictionary)["scanningDate"] as? String)!
            //
            //                                  items.append(item)
            //                              }
        } catch {
            print(error)
        }
        
        
        
        //       do {
        //           let jsonResult: NSArray = try JSONSerialization.jsonObject(with: data,
        //                                                                           options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        //
        //           for myItem in jsonResult {
        //               let item:DeliverNote = DeliverNote()
        //
        //               // Parse JSON data
        //               item.deliveryNoteId = ((myItem as! NSDictionary)["deliveryNoteId"] as? Int)!
        //               item.name = ((myItem as! NSDictionary)["name"] as? String)!
        //               item.scanningDate = ((myItem as! NSDictionary)["scanningDate"] as? String)!
        //
        //               items.append(item)
        //           }
        //       } catch {
        //           print(error)
        //       }
        NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalVariables.actionDeliveryNoteHistoryCompleteNotificationName), object: items)
    }
    
    func fetchDeliveryNoteDetailsDate(_ data: Data){
        var items = [DeliveryNoteDetails]()
        
        let response: ResponseEnvelope<[DeliveryNoteDetails]>
        
        do {
            response = try! JSONDecoder().decode(ResponseEnvelope<[DeliveryNoteDetails]>.self, from: data)
            items = ((response.data ?? nil)!)
            GlobalVariables.sharedManager.deliverNoteDetails = items
            
        }
        catch {
            print(error)
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalVariables.actionDeliveryNoteDetailsCompleteNotificationName), object: nil)
    }
    
    func fetchScanDeliveryNoteData(_ data: Data){
        var items: String  = ""
        NotificationCenter.default.post(name: Notification.Name(rawValue: GlobalVariables.actionScanDeliveryNoteCompleteNotificationName), object: items)
    }
    
    
    
    func SendPOSTRequestWithOperation(_ myOperation: String, AndParameters myParameters: String, AndLoaderText myLoaderText: String, AndCallBackKey myCallBackKey: String, AndRequestType:String, AndShowLoader: Bool) {
        
        let URL: String = "\(GlobalVariables.sharedManager.WebServiceLink)/\(myOperation)/"
        print("URL: \(URL)")
        let myURL: Foundation.URL = Foundation.URL(string: URL)!
        var request: URLRequest = URLRequest(url: myURL)
        
        if (AndRequestType == "POST"){
            //Post Method Configuration Area
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let postData: Data = myParameters.data(using: String.Encoding.ascii, allowLossyConversion: true)!
            //Read the post length
            let postLength: String = "\(UInt(postData.count))"
            request.setValue(postLength, forHTTPHeaderField: "Content-Length")
            request.httpBody = postData
        }
        else{
            request.httpMethod = "GET"
        }
        
        if (GlobalVariables.sharedManager.token != "") {
            let authorizationKey = "Bearer ".appending(GlobalVariables.sharedManager.token)
            print("Token: \(authorizationKey)")
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue(authorizationKey, forHTTPHeaderField: "Authorization")
            request.timeoutInterval = 20000.0
        }
        
        if AndShowLoader {
            //ARSLineProgress.show()
        }
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            
            // Parse JSON data
            if let data = data {
                if (myCallBackKey == GlobalVariables.loginOperation){
                    self.fetchedDataLogin(data)
                }else if (myCallBackKey == GlobalVariables.deliveryNoteHistoryOperation){
                    self.fetchDeliveryNoteData(data)
                }else if(myCallBackKey == GlobalVariables.deliveryNoteDetailsOperation){
                    self.fetchDeliveryNoteDetailsDate(data)
                }else if(myCallBackKey == GlobalVariables.scanDeliveryNoteOperation){
                    self.fetchScanDeliveryNoteData(data)
                }
            }
            if AndShowLoader {
                //ARSLineProgress.hide()
            }
        })
        task.resume()
    }
}
