//
//  MessageCell.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 05/11/24.
//

import SwiftUI

struct MessageCell: View {
    var contentMessage: String
//    @Binding var userEmail: String
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(Color.white)
            .background(Color.blue)
//            .foregroundColor(userEmail ? Color.white : Color.black)
//            .background(userEmail ==  ? Color.blue : Color(UIColor.systemGray6 ))
            .cornerRadius(10)
    }
}

#Preview {
    MessageCell(contentMessage: "Ciao")
}
