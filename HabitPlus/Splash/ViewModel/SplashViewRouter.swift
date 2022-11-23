//
//  SplashViewRouter.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 27/08/22.
//

import SwiftUI

enum SplashViewRouter {
    static func makeSignInView() -> some View {
        let viewModel = SignInViewModel(interactor: SignInInteractor())
        return SignInView(viewModel: viewModel)
    }
}
