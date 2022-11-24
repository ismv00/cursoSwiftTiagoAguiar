//
//  AppError.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 23/11/22.
//

import Foundation

enum AppError: Error {
    case response(message: String)
    
    public var message: String {
        switch self {
        case .response(let message):
            return message
        }
    }
}
