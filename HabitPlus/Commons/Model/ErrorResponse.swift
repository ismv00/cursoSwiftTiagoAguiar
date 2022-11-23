//
//  ErrorResponse.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 11/10/22.
//

import Foundation

struct ErrorResponse : Decodable {
    let detail : String
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
}
