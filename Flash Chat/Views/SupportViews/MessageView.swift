//
//  MessageView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 05/11/24.
//

import SwiftUI

struct MessageView: View {
    var currentMessage: Message
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 10) {
            MessageCell(contentMessage: currentMessage.body)
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .cornerRadius(20)
//            if !currentMessage.isCurrentUser {
//                Image(systemName: "person.circle.fill")
//                    .resizable()
//                    .frame(width: 40, height: 40, alignment: .center)
//                    .cornerRadius(20)
//            } else {
//                Spacer()
//            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .padding()
    }
}


#Preview {
    MessageView(currentMessage: Message(sender: "1@2.com", body: "This is a single message cell with avatar. If user is current user, we won't display the avatar."))
}
