//
//  ManualScannerViewController.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 2/10/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit
class ManualScannerViewController : BaseUICtrl{
  
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(ManualScannerViewController.reactToSendScan(_:)),
            name: NSNotification.Name(rawValue: GlobalVariables.actionScanDeliveryNoteCompleteNotificationName),
            object: nil)
        fixTextBox(txt: txtBarcode)
         
    }
    override func viewDidAppear(_ animated: Bool) {
        if(GlobalVariables.sharedManager.scannedValue != nil && GlobalVariables.sharedManager.scannedValue != ""){
            txtBarcode.text =  GlobalVariables.sharedManager.scannedValue
            submitBarcode()
        }
    }
    @IBAction func btnLogout(_ sender: Any) {
        //  GlobalFunctions.alertLogout(webView: self)
        alertLogout(webView: self)
    }
    
    @objc func reactToSendScan(_ note: Notification) {
        OperationQueue.main.addOperation(){
            self.removeSpinner()
            let response: ResponseEnvelope = try! note.userInfo?["response"] as! ResponseEnvelope<String>;()
            if(response.result == true){
                //Do UI stuff here
                GlobalFunctions.alertInfo(webView: self, strError: response.message ?? "Unknown Error")
            }else{
                GlobalFunctions.alertError(webView: self, strError: response.message ?? "Unknown Error")
            }
        }
    }
    @IBOutlet weak var txtBarcode: UITextField!
    
    @IBAction func btnSubmit(_ sender: Any) {
        submitBarcode()
    }
    func submitBarcode(){
        if(txtBarcode.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            GlobalFunctions.alertError(webView: self, strError: "Please enter a barcode value")
        }else{
            showSpinner(onView: self.view)
            WebFunctions.SendScannedDeliveryNote(code: txtBarcode.text ?? "")
        }
        GlobalVariables.sharedManager.scannedValue = ""
    }
}
