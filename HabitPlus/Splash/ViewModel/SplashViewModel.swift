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
    private var cancellableRefresh: AnyCancellable?
    
    private let interactor: SplashInteractor
    
    init(interactor: SplashInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableAuth?.cancel()
        cancellableRefresh?.cancel()
    }
    
    func onAppear() {
        
       cancellableAuth = interactor.fetchAuth()
            .delay(for:.seconds(2), scheduler: RunLoop.main)
            .receive(on: DispatchQueue.main)
            .sink { userAuth in
                if userAuth == nil {
                    self.uiState = .goToSignInScreen
                }else if (Date().timeIntervalSince1970 > Double(userAuth!.expires)) {
                    // chamar o refresh token
                    print("Token Expirado")
                    let request = RefreshRequest(token: userAuth!.refreshToken)
                    self.cancellableRefresh = self.interactor.refreshToken(refreshRequest:request)
                        .receive(on: DispatchQueue.main)
                        .sink(receiveCompletion: { completion in
                            switch(completion) {
                            case .failure(_):
                                self.uiState = .goToHomeScreen
                                break
                            default :
                                break
                            }
                        }, receiveValue: { success in
                            
                                let auth  = UserAuth(idToken: success.accessToken,
                                                     refreshToken: success.refreshToken,
                                                     expires: Date().timeIntervalSince1970 + Double(success.expires),
                                                     tokenType: success.tokenType)
                            self.interactor.insertAuth(userAuth:auth)
                                
                                self.uiState = .goToHomeScreen
                            
                        })
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
    
    func HomeView() -> some View {
        return SplashViewRouter.makeHomeView()
    }
}
