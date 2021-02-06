//
//  DeliveryNote.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/18/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
struct DeliverNote: Hashable,  Codable{

//    var id: ObjectIdentifier
    var deliveryNoteId: Int
    var scanningDate: String
    var name: String
}
