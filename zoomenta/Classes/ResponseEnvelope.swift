//
//  ResponseEnvelop.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/23/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
class ResponseEnvelope<T : Decodable> : Decodable{
    
    init(result: Bool, message: String, _ value: T) {
        self.data = value
        self.message = message
        self.result = result
    }
    var result: Bool?
    var message: String?
    var data: T?
}
