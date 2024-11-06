//
//  ChatView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import Combine
import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ChatView: View {
    
    @EnvironmentObject var shared: NavigationManager
    @State private var newMessage: String = ""
    let db = Firestore.firestore()
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hey"),
        Message(sender: "a@b.com", body: "Hello"),
        Message(sender: "1@2.com", body: "What's up?")
        
    ]
    
    
    var body: some View {

        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(messages, id: \.self) { message in
                            MessageView(currentMessage: message)
                                .id(message)
                        }
                    }

                }

                HStack {
                    TextField("Send a message", text: $newMessage)
                        .textFieldStyle(.roundedBorder)
                    Button {
                        sendMessage()
                    } label: {
                        Image(systemName: "paperplane")
                    }
                }
                .padding()
            }
        }
    }
    
    func sendMessage() {
        
        if let messageSender = Auth.auth().currentUser?.email {
            let messageBody = newMessage
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody]) { error in
                    if let e = error {
                        print("Error adding document: \(e)")
                    } else {
                        print("Successfully saved data")
                    }
                }
        }
    }
}

#Preview {
    ChatView()
}
