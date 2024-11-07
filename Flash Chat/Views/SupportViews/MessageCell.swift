//
//  MessageCell.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 05/11/24.
//

import SwiftUI

struct MessageCell: View {
    var currentMessage: String
    var isCurrentUser: Bool
    
    var body: some View {
        
        Text(currentMessage)
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color.black)
            .background(isCurrentUser ? Color.blue : Color(UIColor.systemGray ))
            .cornerRadius(10)
        
    }
}

#Preview {
    MessageCell(currentMessage: "Ciao", isCurrentUser: true)
}
