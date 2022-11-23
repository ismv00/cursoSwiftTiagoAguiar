//
//  EditTextView.swift
//  HabitPlus
//
//  Created by Igor S. Menezes on 18/09/22.
//

import SwiftUI

struct EditTextView: View {
    @Binding var text: String
    
    var  placeHolder: String = ""
    var error : String? = nil
    var keyboard: UIKeyboardType = .default
    var failure : Bool? = nil
    var isSecure : Bool = false
    
    var body: some View {
        VStack {
            
            if isSecure {
                SecureField(placeHolder, text: $text)
                    .foregroundColor(Color("testColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            }
            else {
                TextField(placeHolder, text: $text)
                    .foregroundColor(Color("testColor"))
                    .keyboardType(keyboard)
                    .textFieldStyle(CustomTextFieldStyle())
            }
            if let error = error, failure == true, !text.isEmpty {
                Text(error).foregroundColor(.red)
            }
        }
        .padding(.bottom, 10)
    }
}

struct EditTextView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.self) { value in
            VStack {
                EditTextView(text: .constant("Texto"),
                placeHolder: "Email",
                error: "Campo Inválido",
                             failure: "a@a.com".count < 3)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
                .previewDevice("iPhone 14 Pro Max")
                .preferredColorScheme(value)
        }
    }
}
