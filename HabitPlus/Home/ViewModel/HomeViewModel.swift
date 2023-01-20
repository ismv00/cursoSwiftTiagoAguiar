//
//  HomeViewModel.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 29/08/22.
//

import SwiftUI

class HomeViewModel : ObservableObject {
    
}

extension HomeViewModel {
    func habitView() -> some View{
        return HomeViewRouter.makeHabitView()
    }
}
