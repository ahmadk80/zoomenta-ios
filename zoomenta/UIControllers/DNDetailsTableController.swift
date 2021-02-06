//
//  DNDetailsTableController.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 2/6/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit
class DNDetailsTableController: UITableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GlobalVariables.sharedManager.deliverNoteDetails.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath);
        cell.textLabel?.text = String(GlobalVariables.sharedManager.deliverNoteDetails[indexPath.row].cardId)
        return cell;
    }
}
