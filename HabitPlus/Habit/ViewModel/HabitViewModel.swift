//
//  HabitViewModel.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 19/01/23.
//

import Foundation

class HabitViewModel: ObservableObject {
    @Published var uiState: HabitUIState = .loading
}
