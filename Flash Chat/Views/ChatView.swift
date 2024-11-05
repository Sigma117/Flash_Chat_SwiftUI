//
//  ChatView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import Combine
import SwiftUI
import FirebaseAuth

struct ChatView: View {
    
    @EnvironmentObject var shared: NavigationManager
    @State var newMessage: String = ""
    
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hey"),
        Message(sender: "a@b.com", body: "Hello"),
        Message(sender: "1@2.com", body: "What's up?")
        
    ]
    
    
    var body: some View {
        
        //        List(messages, id: \.self) { message in
        //            MessageView(currentMessage: message)
        //                .listRowSeparator(.hidden)
        //        }
        VStack {
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(messages, id: \.self) { message in
                            MessageView(currentMessage: message)
                                .id(message)
                        }
                    }
//                    .onReceive(Just(messages)) { _ in
//                        withAnimation {
//                            proxy.scrollTo(messages.last, anchor: .bottom)
//                        }
//                        
//                    }.onAppear {
//                        withAnimation {
//                            proxy.scrollTo(messages.last, anchor: .bottom)
//                        }
//                    }
                }
                
                // send new message
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
        
//        if !newMessage.isEmpty{
//            messages.append(Message(content: newMessage, isCurrentUser: true))
//            messages.append(Message(content: "Reply of " + newMessage , isCurrentUser: false))
//            newMessage = ""
//        }
    }
}

#Preview {
    ChatView()
}
