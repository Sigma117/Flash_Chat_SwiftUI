//
//  LoginView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import SwiftUI



struct LoginView: View {
    
    @EnvironmentObject var naviagationManager: NavigationManager
    var body: some View {
        
        Button {
            naviagationManager.push(.welcomeView)
        } label: {
            Text("test")
        }
    }
}

#Preview {
    LoginView()
}
