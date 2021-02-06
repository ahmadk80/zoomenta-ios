//
//  DeliveryNoteTableViewController.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/30/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import UIKit

class DeliveryNoteTableViewController: UITableViewController {
    
    var pickerToolbar: UIToolbar?
    var dateTextField: UITextField?
    var dateTextField1: UITextField?
    var datePicker = UIDatePicker()
    
 
    @IBOutlet var tblTableView: UITableView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(DeliveryNoteTableViewController.reactToLoadDeliveryResult(_:)),
            name: NSNotification.Name(rawValue: GlobalVariables.actionDeliveryNoteHistoryCompleteNotificationName),
            object: nil)
        var monthCom = DateComponents()
        monthCom.month = -10
        
        let currCalendar = Calendar.current
        let fromDate = currCalendar.date(byAdding: monthCom, to: Date()) ?? Date()
        WebFunctions.GetDeliveryNoteHistory(from: fromDate, to: Date())
        
        
        //        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "deliveryNoteCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    @objc func reactToLoadDeliveryResult(_ note: Notification) {
        OperationQueue.main.addOperation(){
            //                    self.tableView.dataSource = GlobalVariables.sharedManager.deliverNotes as! UITableViewDataSource
            //                    self.tableView.reloadData()
            self.tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    override  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//        let mainTabBarController = storyBoard.instantiateViewController(identifier:  "DeliveryNoteDetails")
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        GlobalVariables.sharedManager.selectedDeliveryNote = GlobalVariables.sharedManager.deliverNotes[indexPath.row].deliveryNoteId
        performSegue(withIdentifier: "segueDNDetails", sender: nil)
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryNoteHeaderCell") as! DeliveryNoteHeaderCell
        
        return cell
        //create the UITextfield to present the Date Picker
        //createUITextField(viewParam: self.view)
        //        let myview = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: tableView.frame.size.height))
        //        let myLabel = UILabel()
        //        myLabel.textColor = UIColor.black
        //        myLabel.text = "From: "
        //        //  myLabel.font = UIFont.systemFont(ofSize: 24.0)
        //        myLabel.translatesAutoresizingMaskIntoConstraints = false
        //        myview.addSubview(myLabel)
        //
        //        //        let myLabel2 = UILabel()
        //        //        myLabel2.textColor = UIColor.brown
        //        //        myLabel2.text = " (MM/DD/YY) "
        //        //        myLabel2.font = UIFont.systemFont(ofSize: 24.0)
        //        //        myLabel2.translatesAutoresizingMaskIntoConstraints = false
        //        //        self.view.addSubview(myLabel2)
        //
        //        dateTextField = UITextField()
        //        dateTextField?.text = "Select a date ..."
        //        //                              dateTextField?.textColor = UIColor.black
        //        //                              dateTextField?.font = UIFont.systemFont(ofSize: 24.0)
        //        //                              dateTextField?.layer.borderColor = UIColor.lightGray.cgColor
        //        //                              dateTextField?.layer.borderWidth = 1.0
        //        //                              dateTextField?.layer.cornerRadius = 3;
        //        dateTextField?.translatesAutoresizingMaskIntoConstraints = false
        //        myview.addSubview(dateTextField!)
        //
        //        let myLabel1 = UILabel()
        //        myLabel1.textColor = UIColor.black
        //        myLabel1.text = "To: "
        //        myLabel1.translatesAutoresizingMaskIntoConstraints = false
        //        myview.addSubview(myLabel1)
        //        dateTextField1 = UITextField()
        //        dateTextField1?.text = "Select a date ..."
        //        dateTextField1?.translatesAutoresizingMaskIntoConstraints = false
        //        myview.addSubview(dateTextField1!)
        //
        //        var allConstraints: [NSLayoutConstraint] = []
        //        let views = ["view": view!, "myLabel": myLabel, "dateTextField": dateTextField , "myLabel1": myLabel1, "dateTextField1": dateTextField1]
        //
        //        let horizontalConstraints = NSLayoutConstraint.constraints(
        //            withVisualFormat: "H:|-[myLabel]-[dateTextField(200)]-|",
        //            options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views as [String : Any])
        //        allConstraints += horizontalConstraints
        //
        //        var verticalConstraints = NSLayoutConstraint.constraints(
        //            withVisualFormat: "V:|-(>=40)-[myLabel]", metrics: nil, views: views as [String : Any])
        //        allConstraints += verticalConstraints
        //        verticalConstraints = NSLayoutConstraint.constraints(
        //            withVisualFormat: "V:|-(>=40)-[dateTextField]", metrics: nil, views: views as [String : Any])
        //        allConstraints += verticalConstraints
        //
        //        let horizontalConstraints1 = NSLayoutConstraint.constraints( withVisualFormat: "H:|-[myLabel1]-[dateTextField1(200)]-|", options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views as [String : Any])
        //        allConstraints += horizontalConstraints1
        //
        //        verticalConstraints = NSLayoutConstraint.constraints(
        //            withVisualFormat: "V:|-(>=40)-[myLabel1]", metrics: nil, views: views as [String : Any])
        //        allConstraints += verticalConstraints
        //        verticalConstraints = NSLayoutConstraint.constraints(
        //            withVisualFormat: "V:|-(>=40)-[dateTextField1]", metrics: nil, views: views as [String : Any])
        //        allConstraints += verticalConstraints
        //        allConstraints += verticalConstraints
        //
        //        NSLayoutConstraint.activate(allConstraints)
        //        //create the Toolbar for Cancel and Done buttons
        //        createUIToolBar()
        //
        //        //set date picker mode
        //        datePicker.datePickerMode = .date
        //
        //        //add toolbar to textField
        //        dateTextField?.inputAccessoryView = pickerToolbar
        //
        //        //add datepicker to textField
        //        dateTextField?.inputView = datePicker
        //        return myview
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryNoteCell", for: indexPath) as! DeliveryNoteCell
        print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row)")
        
        cell.lblName.text = GlobalVariables.sharedManager.deliverNotes[indexPath.row].name
        
        
        
        cell.lblDate.text = String(GlobalVariables.sharedManager.deliverNotes[indexPath.row].scanningDate.prefix(10))
        
        return cell
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    @IBOutlet weak var lblFrom: UILabel!
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(GlobalVariables.sharedManager.deliverNotes == nil){
            return 0
        }
        
        return GlobalVariables.sharedManager.deliverNotes.count
    }
    
    
    func createUITextField(viewParam: UIView){
        
        let myLabel = UILabel()
        myLabel.textColor = UIColor.black
        myLabel.text = "Date: "
        myLabel.font = UIFont.systemFont(ofSize: 24.0)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        viewParam.addSubview(myLabel)
        
        //        let myLabel2 = UILabel()
        //        myLabel2.textColor = UIColor.brown
        //        myLabel2.text = " (MM/DD/YY) "
        //        myLabel2.font = UIFont.systemFont(ofSize: 24.0)
        //        myLabel2.translatesAutoresizingMaskIntoConstraints = false
        //        self.view.addSubview(myLabel2)
        
        dateTextField = UITextField()
        dateTextField?.text = "Select a date ..."
        dateTextField?.textColor = UIColor.black
        dateTextField?.font = UIFont.systemFont(ofSize: 24.0)
        dateTextField?.layer.borderColor = UIColor.lightGray.cgColor
        dateTextField?.layer.borderWidth = 1.0
        dateTextField?.layer.cornerRadius = 3;
        dateTextField?.translatesAutoresizingMaskIntoConstraints = false
        viewParam.addSubview(dateTextField!)
        
        
        var allConstraints: [NSLayoutConstraint] = []
        let views = ["view": view!, "myLabel": myLabel, "dateTextField": dateTextField]// , "myLabel2": myLabel2]
        
        let horizontalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[myLabel]-[dateTextField(200)]-|",
            options: [.alignAllTop, .alignAllBottom], metrics: nil, views: views as [String : Any])
        allConstraints += horizontalConstraints
        
        var verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(>=40)-[myLabel]", metrics: nil, views: views as [String : Any])
        allConstraints += verticalConstraints
        verticalConstraints = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-(>=40)-[dateTextField]", metrics: nil, views: views as [String : Any])
        allConstraints += verticalConstraints
        
        allConstraints += verticalConstraints
        
        
        NSLayoutConstraint.activate(allConstraints)
        
    }
    
    func createUIToolBar() {
        
        pickerToolbar = UIToolbar()
        pickerToolbar?.autoresizingMask = .flexibleHeight
        
        //customize the toolbar
        pickerToolbar?.barStyle = .default
        pickerToolbar?.barTintColor = UIColor.black
        pickerToolbar?.backgroundColor = UIColor.white
        pickerToolbar?.isTranslucent = false
        
        //add buttons
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action:
            #selector(cancelBtnClicked(_:)))
        cancelButton.tintColor = UIColor.white
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action:
            #selector(self.doneBtnClicked(_:)))
        doneButton.tintColor = UIColor.white
        
        //add the items to the toolbar
        pickerToolbar?.items = [cancelButton, flexSpace, doneButton]
        
    }
    
    @objc func cancelBtnClicked(_ button: UIBarButtonItem?) {
        dateTextField?.resignFirstResponder()
    }
    
    @objc func doneBtnClicked(_ button: UIBarButtonItem?) {
        dateTextField?.resignFirstResponder()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        dateTextField?.text = formatter.string(from: datePicker.date)
    }
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
