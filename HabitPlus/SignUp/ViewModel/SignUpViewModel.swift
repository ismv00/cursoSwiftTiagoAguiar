//
//  SignUpViewModel.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 10/09/22.
//

import SwiftUI
import Combine

class SignUpViewModel : ObservableObject {
    var publisher: PassthroughSubject<Bool, Never>!
    
    @Published var uiState: SignUpUiState = .none
    
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var document = " "
    @Published var phone = ""
    @Published var birthday = ""
    @Published var gender = Gender.male
    
    func signUp() {
        self.uiState = .loading
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "dd/MM/yyyy"
        
        let dateFormatted = formatter.date(from: birthday)
        
        guard let dateFormatted = dateFormatted else {
            self.uiState = .error("Data Inválida \(birthday)")
            return
        }
        
        formatter.dateFormat = "yyy-MM-dd"
        
        let birthday = formatter.string(from: dateFormatted)
        
        WebService.postUser(request: SignUpRequest(fullName: fullName,
                                                   email: email,
                                                   password: password,
                                                   document: document,
                                                   phone: phone,
                                                   birthday: birthday,
                                                   gender: gender.index)){ (successResponse, errorResponse) in
            if let error = errorResponse {
                DispatchQueue.main.async {
                    self.uiState = .error(error.detail)
                }
            }
            
            if let success = successResponse {
//                WebService.login(request: SignInRequest(email: self.email, password: self.password)) { (successResponse, errorResponse) in
//                    if let errorSignIn = errorResponse {
//                        DispatchQueue.main.async {
//                            self.uiState = .error(errorSignIn.detail.message)
//                        }
//                    }
//                    if let successSignIn = successResponse {
//                        DispatchQueue.main.async {
//                            print(successSignIn)
//                            self.publisher.send(success)
//                            self.uiState = .success
//                        }
//                    }
//                }
            }
        }
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}