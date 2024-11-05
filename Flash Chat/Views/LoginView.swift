//
//  LoginView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import SwiftUI



struct LoginView: View {
    
    @EnvironmentObject var shared: NavigationManager
    var body: some View {
        
        Button {
            shared.path.append(NavigationDestination.welcomeView)
        } label: {
            Text("test")
                .font(.title)
        }
    }
}

#Preview {
    LoginView()
}
