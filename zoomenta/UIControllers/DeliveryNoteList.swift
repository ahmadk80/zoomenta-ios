//
//  DeliveryNoteList.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/30/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import SwiftUI

struct DeliveryNoteList: View {
    var body: some View {
        List(GlobalVariables.sharedManager.deliverNotes, id: \.self){
            deliveryNote in DeliveryNoteRow(deliveryNote: deliveryNote)
        }
    }
}

struct DeliveryNoteList_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryNoteList()
    }
}
