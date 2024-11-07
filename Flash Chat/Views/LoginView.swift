//
//  LoginView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import SwiftUI
import os.log
import FirebaseAuth



struct LoginView: View {
    
    @EnvironmentObject var shared: NavigationManager
    @State private var email: String = "1@2.com"
    @State private var password: String = "123456"
    @State private var showAlert: Bool = false
    @State private var errorMessage: String?
    @State private var disableButton: Bool = false
    
    
    var body: some View {
        
        VStack {
            TextField("Email", text: $email)
                .modifier(ModifierTextFieldStyle())
                .autocapitalization(.none)
            
            SecureField("Passoword", text: $password)
                .modifier(ModifierTextFieldStyle())
            
            Button {
                disableButton = true
                loginUser(email, password)
            } label: {
                Text("Log in")
                    .modifier(ModifierTextStyle())
            }.disabled(disableButton)
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }.onAppear {
            disableButton = false
        }
    }
    
    
    func loginUser(_ email: String, _ password: String) {
        if email.isEmpty || password.isEmpty {
            os.Logger(subsystem: "RegistrationView", category: "Auth").debug("Email or password is empty")
            disableButton = false
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    errorMessage = e.localizedDescription
                    showAlert = true
                    disableButton = false
                } else {
                    shared.path.append(NavigationDestination.chatView)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
