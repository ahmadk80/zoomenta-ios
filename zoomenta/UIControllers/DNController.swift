//
//  DNController.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 3/26/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit
class DNController
: BaseUICtrl, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var txtToDate: UITextField!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(GlobalVariables.sharedManager.deliverNotes == nil){
            return 0
        }
        
        return GlobalVariables.sharedManager.deliverNotes.count
        
    }
    @IBOutlet weak var txtFromDate: UITextField!
   
    var searchActive: Bool = false
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        GlobalVariables.sharedManager.filtered = GlobalVariables.sharedManager.deliverNoteDetails.filter({ (text) -> Bool in
            let tmp: NSString = text.fullNameAr as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(GlobalVariables.sharedManager.filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        tblDetails.reloadData()
    }
    
    @IBOutlet weak var tblDetails: UITableView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryNoteHeaderCell") as! DeliveryNoteHeaderCell
        cell.lblDate.text = "Date"
        return cell
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryNoteCell", for: indexPath) as! DeliveryNoteCell
        cell.nameLabel.text = GlobalVariables.sharedManager.deliverNotes[indexPath.row].name
        
        
        
        cell.dateLabel.text = String(GlobalVariables.sharedManager.deliverNotes[indexPath.row].scanningDate.prefix(10))
        
        
        return cell;
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row % 2 == 0)
        {
            cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        else
        {
            cell.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.9254901961, blue: 0.7764705882, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = #colorLiteral(red: 0.6705882353, green: 0.7647058824, blue: 0.2196078431, alpha: 1)
    }
    
    var format = DateFormatter()
    override func viewWillAppear(_ animated: Bool) {
        self.showSpinner(onView: self.view)
    }
    override func viewDidLoad() {
         format.dateStyle = .medium
               NotificationCenter.default.addObserver(
                   self,
                   selector: #selector(DNController.reactToLoadDeliveryResult(_:)),
                   name: NSNotification.Name(rawValue: GlobalVariables.actionDeliveryNoteHistoryCompleteNotificationName),
                   object: nil)
               var monthCom = DateComponents()
               monthCom.month = -10
               
               let currCalendar = Calendar.current
               let fromDate = currCalendar.date(byAdding: monthCom, to: Date()) ?? Date()
               txtFromDate.text = format.string(from: fromDate)
               txtToDate.text = format.string(from: Date())
               WebFunctions.GetDeliveryNoteHistory(from: format.date(from: txtFromDate.text!)!, to: format.date(from: txtToDate.text!)!)
               self.txtFromDate.setInputViewDatePicker(target: self, selector: #selector(tapDoneFrom)) //1
               self.txtToDate.setInputViewDatePicker(target: self, selector: #selector(tapDoneTo)) //1
               
               super.fixTextBox(txt: txtFromDate)
               super.fixTextBox(txt: txtToDate)
    }
    override func viewDidAppear(_ animated: Bool) {
        
//        format.dateStyle = .medium
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(DNController.reactToLoadDeliveryResult(_:)),
//            name: NSNotification.Name(rawValue: GlobalVariables.actionDeliveryNoteHistoryCompleteNotificationName),
//            object: nil)
//        var monthCom = DateComponents()
//        monthCom.month = -10
//
//        let currCalendar = Calendar.current
//        let fromDate = currCalendar.date(byAdding: monthCom, to: Date()) ?? Date()
//        txtFromDate.text = format.string(from: fromDate)
//        txtToDate.text = format.string(from: Date())
       WebFunctions.GetDeliveryNoteHistory(from: format.date(from: txtFromDate.text!)!, to: format.date(from: txtToDate.text!)!)
//        self.txtFromDate.setInputViewDatePicker(target: self, selector: #selector(tapDoneFrom)) //1
//        self.txtToDate.setInputViewDatePicker(target: self, selector: #selector(tapDoneTo)) //1
//
//        super.fixTextBox(txt: txtFromDate)
//        super.fixTextBox(txt: txtToDate)
    }
    //2
    @objc func tapDoneFrom() {
        if let datePicker = self.txtFromDate.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.txtFromDate.text = dateformatter.string(from: datePicker.date) //2-4
            self.showSpinner(onView: self.view)
            WebFunctions.GetDeliveryNoteHistory(from: format.date(from: txtFromDate.text!)!, to: format.date(from: txtToDate.text!)!)
        }
        self.txtFromDate.resignFirstResponder() // 2-5
    }
    
    @objc func tapDoneTo() {
        if let datePicker = self.txtToDate.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter() // 2-2
            dateformatter.dateStyle = .medium // 2-3
            self.txtToDate.text = dateformatter.string(from: datePicker.date) //2-4
            self.showSpinner(onView: self.view)
            WebFunctions.GetDeliveryNoteHistory(from: format.date(from: txtFromDate.text!)!, to: format.date(from: txtToDate.text!)!)
        }
        self.txtToDate.resignFirstResponder() // 2-5
    }
    @objc func reactToLoadDeliveryResult(_ note: Notification) {
        OperationQueue.main.addOperation(){
            self.tblDetails.dataSource = self
            self.tblDetails.delegate =  self
            self.tblDetails.reloadData()
            self.removeSpinner()
            if(GlobalVariables.sharedManager.deliverNotes.count == 0){
                self.showAlert(withTitle: "No Data", message: "There is no data found")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GlobalVariables.sharedManager.selectedDeliveryNote = GlobalVariables.sharedManager.deliverNotes[indexPath.row].deliveryNoteId
        performSegue(withIdentifier: "segueDNDetails", sender: nil)
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if(indexPath.row % 2 == 0)
//        cell.kCTBackgroundColorAttributeName.color
//    }
    
    @IBAction func btnLogout(_ sender: Any) {
        alertLogout(webView: self)
    }
}
