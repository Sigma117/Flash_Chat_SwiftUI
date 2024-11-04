//
//  WelcomeView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import SwiftUI

struct WelcomeView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @State private var titleLabel = ""
    @State private var charIndex = 0.0
    let titleText = "⚡️ FlashChat"
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                
                Text(titleLabel)
                    .bold()
                    .font(.largeTitle)
                    .italic()
                    .foregroundStyle(Color .blue)
                    
            }
            Spacer()
            Button {
                navigationManager.push(.registrationView)
                titleLabel = ""
                charIndex = 0.0
            } label: {
                Text("sign in")
                    .modifier(ModifierTextStyle())
            }
            
            Button {
                navigationManager.push(.loginView)
                titleLabel = ""
                charIndex = 0.0
            } label: {
                Text("login")
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
        }
    }
}


#Preview {
    WelcomeView()
}
