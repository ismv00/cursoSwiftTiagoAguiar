//
//  HabitUIState.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 19/01/23.
//

import Foundation

enum HabitUIState: Equatable {
    case loading
    case emptyList
    case fullList
    case error(String)
}
