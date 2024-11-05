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
    
    
    var body: some View {
        
        VStack {
            
            TextField("email", text: $email)
                .modifier(ModifierTextFieldStyle())
            
            SecureField("passoword", text: $password)
                .modifier(ModifierTextFieldStyle())
            
            
            Button {
                //                createUser(email, password)
                shared.path.append(NavigationDestination.chatView)
                
            } label: {
                Text("Register")
                    .modifier(ModifierTextStyle())
            }
        }
    }
    
    
    func createUser(_ email: String, _ password: String) {
        if email.isEmpty || password.isEmpty {
            os.Logger(subsystem: "RegistrationView", category: "Auth").debug("Email or password is empty")
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e) // if we wanna actually deploy this app, we neet to throw back this error to the user
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
