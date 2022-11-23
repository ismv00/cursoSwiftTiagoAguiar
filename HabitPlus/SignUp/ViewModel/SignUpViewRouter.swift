//
//  SignUpViewRouter.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 10/09/22.
//

import SwiftUI
import Combine

enum SignUpViewRouter {
    static func makeHomeView() -> some View {
        let viewModel = HomeViewModel()
        return HomeView(viewModel: viewModel)
    }
    
   
}
