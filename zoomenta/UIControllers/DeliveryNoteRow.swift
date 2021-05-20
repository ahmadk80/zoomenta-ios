//
//  DeliveryNoteRow.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/30/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import SwiftUI

struct DeliveryNoteRow: View {
    var deliveryNote: DeliverNote
    var body: some View {
        HStack{
            Text(deliveryNote.name)

            Text(deliveryNote.scanningDate)

            Spacer()
        }
 
    }
    


struct DeliveryNoteRow_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryNoteRow(deliveryNote: GlobalVariables.sharedManager.deliverNotes[0])
            .previewLayout(.fixed(width: 300, height: 50))
     
    }
}
}
