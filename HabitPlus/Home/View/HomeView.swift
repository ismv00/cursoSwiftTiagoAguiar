//
//  HomeView.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 29/08/22.
//

import SwiftUI

struct HomeView : View {
    
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        Text("Ola home page")
    }
}

struct HomeView_Previews : PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
