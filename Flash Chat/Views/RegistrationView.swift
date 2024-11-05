//
//  RegistrationView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import SwiftUI
import FirebaseAuth
import os

struct RegistrationView: View {
    
    @EnvironmentObject var shared: NavigationManager
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert: Bool = false
    @State private var errorMessage: String?
    
    
    var body: some View {
        
        VStack {
            
            TextField("Email", text: $email)
                .modifier(ModifierTextFieldStyle())
            
            SecureField("Passoword", text: $password)
                .modifier(ModifierTextFieldStyle())
            
            Button {
                createUser(email, password)
            } label: {
                Text("Register")
                    .modifier(ModifierTextStyle())
            }
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
    }
    
    
    func createUser(_ email: String, _ password: String) {
        if email.isEmpty || password.isEmpty {
            os.Logger(subsystem: "RegistrationView", category: "Auth").debug("Email or password is empty")
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    errorMessage = e.localizedDescription
                    showAlert = true
                    //.localizedDescription give the user the error in the language they selected in the phone
                } else {
                    shared.path.append(NavigationDestination.chatView)
                }
            }
        }
    }
}

#Preview {
    RegistrationView()
}
