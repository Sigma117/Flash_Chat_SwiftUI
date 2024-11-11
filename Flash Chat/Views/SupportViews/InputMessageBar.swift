//
//  InputMessageBar.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 11/11/24.
//

import SwiftUI

struct InputMessageBar: View {
    
    @Binding var newMessage: String
    var isFocused: FocusState<Bool>.Binding // for pass a @FocusState Bool argument through the view
    var onSend: () -> Void
    
    var body: some View {
        HStack {
            TextField("Send a message", text: $newMessage)
                .textFieldStyle(.roundedBorder)
                .focused(isFocused)
            Button {
                onSend()
            } label: {
                Image(systemName: "paperplane")
            }
        }.padding()
    }
}

#Preview {
    @FocusState var testIsFocused: Bool

    InputMessageBar(newMessage: .constant("Test Message"), isFocused: $testIsFocused, onSend: {})
}
