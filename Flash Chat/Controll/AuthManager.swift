//
//  AuthManager.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 08/11/24.
//

import Foundation
import os
import FirebaseAuth

class AuthManager: ObservableObject {
    
    @Published var isAuthenticated: Bool = false

    func createUser(_ email: String, _ password: String, completion: @escaping (Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                completion(e)
            } else {
                self.isAuthenticated = true
                completion(nil)
            }
        }
    }
    
    func loginUser(_ email: String, _ password: String, completion: @escaping (Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                completion(e)
            } else {
                self.isAuthenticated = true
                completion(nil)
            }
        }
    }
}
