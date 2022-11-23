//
//  SignUpView.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 01/09/22.
//

import SwiftUI

struct SignUpView : View {
   
    
    @ObservedObject var viewModel: SignUpViewModel
    
    
    var body : some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cadastro")
                            .foregroundColor(Color("testColor"))
                            .font(Font.system(.title).bold())
                            .padding(.bottom, 8)
                        
                        fullNameField
                        emailField
                        passwordField
                        documentField
                        phoneField
                        birthdayField
                        genderField
                        saveButton
                        
                    }
                    Spacer()
                }.padding(.horizontal, 8)
            }.padding()
            if case SignUpUiState.error(let value) = viewModel.uiState {
                Text("")
                    .alert(isPresented: .constant(true)) {
                        Alert(title: Text("Habit"), message: Text(value), dismissButton: .default(Text("OK")){
                            // Faz algo
                        })
                    }
            }
        }
    }
}

extension SignUpView {
    var fullNameField: some View {
        EditTextView(text: $viewModel.fullName,
                     placeHolder: "Digite seu nome completo * ",
                     error: "Nome inválido", keyboard: .alphabet,
                     failure: viewModel.fullName.count < 3)
    }
}

extension SignUpView {
    var emailField: some View {
        EditTextView(text: $viewModel.email,
                     placeHolder: "Entre cm seu e-mail *",
                     error: "E-mail inválido", keyboard: .emailAddress,
                     failure: !viewModel.email.isEmail())
    }
}
    
extension SignUpView {
        var passwordField: some View {
            EditTextView(text: $viewModel.password,
                         placeHolder: "Entre com sua senha *",
                         error: "senha deve ter ao menos 8 caracteres", keyboard: .emailAddress,
                         failure: viewModel.password.count < 8,
                         isSecure: true)
        }
}

extension SignUpView {
    var documentField: some View {
        EditTextView(text: $viewModel.document,
                     placeHolder: "Entre cm seu CPF *",
                     error: "CPF inválido", keyboard: .numberPad,
                     failure: viewModel.document.count != 11)
    }
}

extension SignUpView {
    var phoneField: some View {
        EditTextView(text: $viewModel.phone,
                     placeHolder: "Entre com seu celullar",
                     error: "Entre com o DDD + 8 ou 9 digitos", keyboard: .numberPad,
                     failure: viewModel.phone.count  < 10 || viewModel.phone.count >= 12)
    }
}

extension SignUpView {
    var birthdayField: some View {
        EditTextView(text: $viewModel.birthday,
                     placeHolder: "Entre com sua data de nascimento",
                     error: "Data deve ser DD/MM/YYYY", keyboard: .default,
                     failure: viewModel.birthday.count != 10)
    }
}

extension SignUpView {
    var genderField: some View {
        Picker("Gender", selection: $viewModel.gender) {
            ForEach(Gender.allCases, id: \.self) { value in
                Text(value.rawValue)
                    .tag(value)
            }
        }.pickerStyle(SegmentedPickerStyle())
            .padding(.top, 16)
            .padding(.bottom, 32)
    }
}
extension SignUpView {
    var saveButton: some View {
        LoadingButtonView(action: {
            viewModel.signUp()
        }, text: "Realize seu cadastro",
                          showProgress: self.viewModel.uiState == SignUpUiState.loading,
                          disabled: !viewModel.email.isEmail() ||
                          viewModel.password.count < 8 ||
                          viewModel.fullName.count < 3 ||
                          viewModel.document.count != 11 ||
                          viewModel.phone.count  < 10 || viewModel.phone.count >= 12 ||
                          viewModel.birthday.count != 10
            )
        }
    
}


struct SignUpView_Previews : PreviewProvider {
    static var previews : some View {
        ForEach(ColorScheme.allCases, id: \.self) {
            SignUpView(viewModel: SignUpViewModel())
                .previewDevice("iPhone 14 Pro Max")
                .preferredColorScheme($0)
        }
        
    }
}
