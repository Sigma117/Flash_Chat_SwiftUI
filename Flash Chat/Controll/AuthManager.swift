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

    func createUser(_ email: String, _ password: String, completion: @escaping (Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                completion(e)
            } else {
                completion(nil)
            }
        }
    }
    
    func loginUser(_ email: String, _ password: String, completion: @escaping (Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                completion(e)
            } else {
                completion(nil)
            }
        }
    }
    
    func logOutUser() -> NSError? {
        do {
          try Auth.auth().signOut()
            return nil
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            return signOutError
        }
        
    }
}
