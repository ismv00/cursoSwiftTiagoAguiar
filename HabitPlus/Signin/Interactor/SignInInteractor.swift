//
//  SignInInteractor.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 22/11/22.
//

import Foundation
import Combine


class SignInInteractor {
    private let remote: RemoteDataSource = .shared
    // private let local: LocalDataSource
}
extension SignInInteractor {
    func login (loginRequest request: SignInRequest) -> Future<SignInResponse, AppError> {
       return remote.login(request: request)
        
        
    }
}
