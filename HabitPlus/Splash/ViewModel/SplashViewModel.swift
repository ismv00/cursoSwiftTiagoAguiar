//
//  SplashViewModel.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 27/08/22.
//

import SwiftUI

class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUiState = .loading
    
    func onAppear() {
        // faz algo assincrono e muda o state da uistate
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            // aqui é chamado depois de 2 segundos
            self.uiState = .goToSignInScreen
        }
    }
    
    
}

extension SplashViewModel {
    func signInView() -> some View {
        return SplashViewRouter.makeSignInView()
    }
}
