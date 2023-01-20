//
//  HomeViewRouter.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 19/01/23.
//

import Foundation
import SwiftUI

enum HomeViewRouter {
    static func makeHabitView() -> some View {
        let viewModel = HabitViewModel()
        return HabitView(viewModel: viewModel)
    }
}
