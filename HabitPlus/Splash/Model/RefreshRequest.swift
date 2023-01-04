//
//  RefreshRequest.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 03/01/23.
//

import Foundation

struct RefreshRequest: Encodable {
    let token : String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
}
