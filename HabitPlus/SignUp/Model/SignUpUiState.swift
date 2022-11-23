//
//  SignUpUiState.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 10/09/22.
//

import Foundation

enum SignUpUiState : Equatable {
    case none
    case loading
    case success
    case error(String)
}
