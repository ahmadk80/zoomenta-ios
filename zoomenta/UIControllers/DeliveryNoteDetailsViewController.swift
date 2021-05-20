//
//  DeliveryNoteDetailsViewController.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 2/6/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit
class DeliveryNoteDetailsViewController: BaseUICtrl, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var txtDeliveryName: UITextField!
    @IBOutlet weak var txtQuantity: UITextField!
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(indexPath.row % 2 == 0)
        {
            cell.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        }
        else
        {
            cell.backgroundColor = #colorLiteral(red: 0.8980392157, green: 0.9254901961, blue: 0.7764705882, alpha: 1)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.backgroundColor = #colorLiteral(red: 0.6705882353, green: 0.7647058824, blue: 0.2196078431, alpha: 1)
    }
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return GlobalVariables.sharedManager.filtered.count
        }
        return GlobalVariables.sharedManager.deliverNoteDetails.count
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 35
//    }
    var searchActive: Bool = false
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    override func viewWillAppear(_ animated: Bool) {
        self.showSpinner(onView: self.view)
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryNoteDetailsHeaderCell") as! DeliveryNoteDetailsHeaderCell
        
        return cell
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dnDetailsCell", for: indexPath) as! DeliveryNoteDetailsCell
        if(searchActive){
            cell.lblCardId?.text = String(GlobalVariables.sharedManager.filtered[indexPath.row].cardId)
            cell.lblFullNameAr?.text = String(GlobalVariables.sharedManager.filtered[indexPath.row].fullNameAr)
            
        }
        else{
            cell.lblCardId?.text = String(GlobalVariables.sharedManager.deliverNoteDetails[indexPath.row].cardId)
            cell.lblFullNameAr?.text = String(GlobalVariables.sharedManager.deliverNoteDetails[indexPath.row].fullNameAr)
        }
        return cell;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        WebFunctions.GetDeliveryNoteDetails(deliveryNoteId: GlobalVariables.sharedManager.deliverNotes[GlobalVariables.sharedManager.selectedDeliveryNoteIndex].deliveryNoteId, controller: self)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loadDeliveryNoteDetails(_:)),
            name: NSNotification.Name(rawValue: GlobalVariables.actionDeliveryNoteDetailsCompleteNotificationName),
            object: nil)
        
//        rect: CGRect = self.searchBar.frame
//        
//        lineView: UIView = [[UIView, alloc]initWithFrame:CGRectMake(0, rect.size.height-2,rect.size.width, 2)]
//        
//        lineView.backgroundColor = [UIColor whiteColor]
//        
//        [self.searchBar addSubview:lineView];
    }
    
    
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var tblDetails: UITableView!
    @objc func loadDeliveryNoteDetails(_ note: Notification) {
        OperationQueue.main.addOperation(){
            self.tblDetails.dataSource = self
            self.tblDetails.delegate =  self
            self.txtSearch.delegate =  self
            self.tblDetails.reloadData()
            self.removeSpinner()
            if(GlobalVariables.sharedManager.deliverNoteDetails.count == 0){
                self.showAlert(withTitle: "No Data", message: "There is no data found")
            }
            self.txtQuantity.text = String(GlobalVariables.sharedManager.deliverNoteDetails.count)
            
            self.txtDeliveryName.text =    GlobalVariables.sharedManager.deliverNotes[GlobalVariables.sharedManager.selectedDeliveryNoteIndex].name
            
        }
    }
    
}
