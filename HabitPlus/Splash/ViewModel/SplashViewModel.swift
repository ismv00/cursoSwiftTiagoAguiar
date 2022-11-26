//
//  SplashViewModel.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 27/08/22.
//

import SwiftUI
import Combine

class SplashViewModel: ObservableObject {
    @Published var uiState: SplashUiState = .loading
    
    private var cancellableAuth: AnyCancellable?
    
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
    }
    
    func onAppear() {
        
       cancellableAuth = interactor.fetchAuth()
            .delay(for:.seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                }else if (Date().timeIntervalSince1970 > Date().timeIntervalSince1970 + Double(userAuth!.expires)) {
                    // chamar o refresh token
                    print("Token Expirado")
                    // se expirado
                }
                else {
                    self.uiState = .goToHomeScreen
                }
            }
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
