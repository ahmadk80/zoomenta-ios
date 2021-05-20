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
  
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnSubmit: UIButton!
    @IBOutlet weak var btnScanBarcode: UIButton!
    
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
        roundAButton(btn: btnScanBarcode)
        roundAButton(btn: btnSubmit)
         
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
        OperationQueue.main.addOperation(){ [self] in
            self.removeSpinner()
            let response: ResponseEnvelope = try! note.userInfo?["response"] as! ResponseEnvelope<String>;()
            
            
            self.lblError.isHidden = false
            if(response.result == true){
                //Do UI stuff here
                self.lblError.text = response.message
                self.lblError.textColor = UIColor.gray
                //GlobalFunctions.alertInfo(webView: self, strError: response.message ?? "Unknown Error")
            }else{
                self.lblError.text = response.message
                self.lblError.textColor = UIColor.red
                //GlobalFunctions.alertError(webView: self, strError: response.message ?? "Unknown Error")
            }
        }
    }
    @IBOutlet weak var txtBarcode: UITextField!
    
    @IBAction func btnSubmit(_ sender: Any) {
        submitBarcode()
    }
    func submitBarcode(){
        self.lblError.isHidden = true
        if(txtBarcode.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            self.lblError.isHidden = false
            self.lblError.text = "Please enter a barcode value"
            self.lblError.textColor = UIColor.red
           // GlobalFunctions.alertError(webView: self, strError: "Please enter a barcode value")
        }else{
            showSpinner(onView: self.view)
            WebFunctions.SendScannedDeliveryNote(code: txtBarcode.text ?? "", controller: self)
        }
        GlobalVariables.sharedManager.scannedValue = ""
    }
}
