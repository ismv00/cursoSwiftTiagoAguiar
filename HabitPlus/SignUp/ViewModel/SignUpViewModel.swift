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
    
    private var cancellableSignUp: AnyCancellable?
    private var cancellableSignIn: AnyCancellable?
    
    @Published var uiState: SignUpUiState = .none
    private let interactor: SignUpInteractor
    
    init(interactor: SignUpInteractor) {
        self.interactor = interactor
    }
    
    deinit {
        cancellableSignUp?.cancel()
        cancellableSignIn?.cancel()
    }
    
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
        
        let signUpRequest = SignUpRequest(fullName: fullName,
                                          email: email,
                                          password: password,
                                          document: document,
                                          phone: phone,
                                          birthday: birthday,
                                          gender: gender.index)
        cancellableSignUp = interactor.postUser(signUpRequest: signUpRequest)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch(completion) {
                case .failure(let appError):
                    self.uiState = .error(appError.message)
                    break
                case .finished:
                    break
                }
            } receiveValue: { created in
                if (created) {
                    self.cancellableSignIn = self.interactor.login(signInRequest: SignInRequest(email: self.email, password: self.password))
                        .receive(on: DispatchQueue.main)
                        .sink { completion in
                            switch(completion) {
                            case .failure(let appError):
                                self.uiState = .error(appError.message)
                                break
                            case .finished:
                                break
                            }
                        } receiveValue: { successSignIn in
                            print(created)
                            self.publisher.send(created)
                            self.uiState = .success
                        }

            }

        
//        interactor.postUser(SignUpRequest: signUpRequest) { (successResponse, errorResponse) in
//            if let error = errorResponse {
//                DispatchQueue.main.async {
//                    self.uiState = .error(error.detail)
//                }
//            }
            
//            if let success = successResponse {
////                WebService.login(request: SignInRequest(email: self.email, password: self.password)) { (successResponse, errorResponse) in
////                    if let errorSignIn = errorResponse {
////                        DispatchQueue.main.async {
////                            self.uiState = .error(errorSignIn.detail.message)
////                        }
////                    }
////                    if let successSignIn = successResponse {
////                        DispatchQueue.main.async {
////                            print(successSignIn)
////                            self.publisher.send(success)
////                            self.uiState = .success
////                        }
////                    }
////                }
//            }
        }
    }
}

extension SignUpViewModel {
    func homeView() -> some View {
        return SignUpViewRouter.makeHomeView()
    }
}
