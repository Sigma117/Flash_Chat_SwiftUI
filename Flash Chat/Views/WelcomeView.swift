//
//  WelcomeView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var shared: NavigationManager
    @State private var titleLabel = ""
    @State private var charIndex = 0.0
    let titleText = K.appName
    
    var body: some View {
        
        NavigationStack(path: $shared.path) {
            VStack {
                Spacer()
                    Text(titleLabel)
                        .bold()
                        .font(.largeTitle)
                        .italic()
                        .foregroundStyle(Color .blue)
                Spacer()
                
                Button {
                    shared.path.append(NavigationDestination.registrationView)
                } label: {
                    Text("Registration")
                        .modifier(ModifierTextStyle())
                }
                
                Button {
                    shared.path.append(NavigationDestination.loginView)
                } label: {
                    Text("Login")
                        .modifier(ModifierTextStyle())
                }

                Spacer()
            }.onAppear {
                for letter in titleText {
                    Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                        titleLabel.append(letter)
                    }
                    self.charIndex += 1
                }
            }.onDisappear {
                titleLabel = ""
                charIndex = 0.0
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .registrationView:
                    RegistrationView()
                case .loginView:
                    LoginView()
                case .welcomeView:
                    WelcomeView()
                case .chatView:
                    ChatView()
                }
            }
        }
    }
}


#Preview {
    WelcomeView()
}
