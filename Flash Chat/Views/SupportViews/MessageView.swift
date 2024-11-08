//
//  MessageView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 05/11/24.
//

import SwiftUI
import FirebaseAuth

struct MessageView: View {
    var currentMessage: Message
    
    var body: some View {
        if let messageSender = Auth.auth().currentUser?.email {
            let isCurrentUser = (currentMessage.sender == messageSender)
            
            HStack(alignment: .bottom, spacing: 10) {
                if !isCurrentUser {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .cornerRadius(20)
                    MessageCell(currentMessage: currentMessage.body, isCurrentUser: isCurrentUser)
                    Spacer()
                } else {
                    Spacer()
                    MessageCell(currentMessage: currentMessage.body, isCurrentUser: isCurrentUser)
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .cornerRadius(20)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
    }
}


#Preview {
    MessageView(currentMessage: Message(sender: "1@2.com", body: "This is a single message cell with avatar. If user is current user, we won't display the avatar."))
}

