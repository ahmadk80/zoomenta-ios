//
//  DeliveryNoteard.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/18/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
struct DeliveryNoteDetails: Hashable, Codable{
    var cardId: Int
    var accountNumber: String
    var fullNameAr: String
    var fullNameEn: String
}
