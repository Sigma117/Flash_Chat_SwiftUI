//
//  UserErrorAlertView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 05/11/24.
//

import SwiftUI

struct UserErrorAlertView: ViewModifier {
    
    var error: Error
    @Binding var showingError: Bool
    
    func body(content: Content) -> some View {
        content
            .alert("Error", isPresented: $showingError, actions: {
                Button("Continuare", role: .cancel, action: {

                })
            }, message: { Text ("\(error)")
        })
    }
}
