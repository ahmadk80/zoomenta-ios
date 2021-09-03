//
//  HomeViewCtrl.swift
//  zoomenta
//
//  Created by Ahmad Kaaki on 9/3/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
import UIKit
class HomeViewCtrl : BaseUICtrl
{
    @IBOutlet weak var btnReturnedCards: UIButton!
    
    @IBOutlet weak var btnCardsList: UIButton!
    @IBOutlet weak var btnScan: UIButton!
    @IBOutlet weak var sideMenuBtn: UIBarButtonItem!
  /*  override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
    }*/
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.sideMenuBtn.target = revealViewController()
        self.sideMenuBtn.action = #selector(self.revealViewController()?.revealSideMenu)
    }
    @IBAction func scanTouch(_ sender: Any) {
        revealViewController()?.selectedCell(1)
    }
    @IBAction func cardsListTouch(_ sender: Any) {
        revealViewController()?.selectedCell(2)
       
         
    }
    @IBAction func returnedCardsTouch(_ sender: Any) {
        revealViewController()?.selectedCell(4)
    }
}
