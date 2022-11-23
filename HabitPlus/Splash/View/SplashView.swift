//
//  SplashView.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 27/08/22.
//

import SwiftUI



struct SplashView : View {
    @ObservedObject var viewModel: SplashViewModel
    
   
    
    var body : some View {
        Group {
            switch viewModel.uiState {
            case .loading:
                loadingView()
            case .goToSignInScreen:
                viewModel.signInView()
            case .goToHomeScreen:
                Text("Carregar tela de home")
            case .error(let msg):
                loadingView(error: msg)
            }
        }.onAppear(perform: {
            viewModel.onAppear()
        })
    }
}

// 3 - Functions
extension SplashView {
    func loadingView(error: String? = nil) -> some View {
        ZStack{
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20) 
                .ignoresSafeArea()
            
            if let error = error{
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(error), dismissButton: .default(Text("Ok")){
                            //Faz algo quando some o alerta
                        
                    })
                }
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            let viewModel = SplashViewModel()
            SplashView(viewModel: viewModel)
                .previewDevice("iPhone 14 Pro Max")
                .preferredColorScheme($0)
        }
        
    }
}

