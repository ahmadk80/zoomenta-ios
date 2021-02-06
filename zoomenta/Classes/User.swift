//
//  User.swift
//  zoomenta
//
//  Created by Ahmad El Kaaki on 1/18/21.
//  Copyright © 2021 Ahmad El Kaaki. All rights reserved.
//

import Foundation
class User: Codable{
    var userId: Int?
    var token: String?
    var fullName: String?
    var deviceId: String?
    var email: String? 
}
