//
//  SignInInteractor.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 22/11/22.
//

import Foundation


class SignInInteractor {
    private let remote: RemoteDataSource = .shared
    // private let local: LocalDataSource
}
extension SignInInteractor {
    func login (loginRequest request: SignInRequest, completion: @escaping (SignInResponse?, SignInErrorResponse?) -> Void) {
        remote.login(request: request, completion: completion)
        
        
    }
}
