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
    @EnvironmentObject var authManager: AuthManager
    @State private var email: String = ""
    @State private var password: String = ""
    
    // Alert e Button
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
                authManager.createUser(email, password) { error in
                    if let e = error {
                        errorMessage = e.localizedDescription
                        showAlert = true
                        disableButton = false
                    } else {
                        shared.path.append(NavigationDestination.chatView)
                    }
                }
            } label: {
                Text("Register")
                    .modifier(ModifierTextStyle())
            }.disabled(disableButton)
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            disableButton = false
        }
    }
}

#Preview {
    RegistrationView()
}
