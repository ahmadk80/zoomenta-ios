//
//  DeliveryNoteDetailsViewController.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 2/6/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit
class DeliveryNoteDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
     
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return GlobalVariables.sharedManager.deliverNoteDetails.count
       }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dnDetailsCell", for: indexPath) as! DeliveryNoteDetailsCell
        
        cell.lblCardId?.text = String(GlobalVariables.sharedManager.deliverNoteDetails[indexPath.row].cardId)
        cell.lblFullNameAr?.text = String(GlobalVariables.sharedManager.deliverNoteDetails[indexPath.row].fullNameAr)
               return cell;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        WebFunctions.GetDeliveryNoteDetails(deliveryNoteId: GlobalVariables.sharedManager.selectedDeliveryNote)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loadDeliveryNoteDetails(_:)),
            name: NSNotification.Name(rawValue: GlobalVariables.actionDeliveryNoteDetailsCompleteNotificationName),
            object: nil)
        
    }
    
    
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var tblDetails: UITableView!
    @objc func loadDeliveryNoteDetails(_ note: Notification) {
        OperationQueue.main.addOperation(){
            self.tblDetails.dataSource = self
            
            self.tblDetails.reloadData()
//            self.tblDetails.dataSource = GlobalVariables.sharedManager.deliverNoteDetails as! UITableViewDataSource
            
        }
    }
    
}
