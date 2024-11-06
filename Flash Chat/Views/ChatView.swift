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
    @FocusState private var isFocused: Bool
    let db = Firestore.firestore()
    
    @State private var messages: [Message] = []
    
    
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
                        .focused($isFocused)
                    Button {
                        sendMessage()
                    } label: {
                        Image(systemName: "paperplane")
                    }
                }.padding()
            }
        }
        .onTapGesture {
            isFocused = false
        }.onAppear() {
            loadMessages()
        }.gesture(
            DragGesture().onChanged { _ in
                isFocused = false
            }
        )
    }
    
    func loadMessages() {
        self.messages = []
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                if let e = error {
                    print("There was an issue retrieving data from Firestore. \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        messages = []
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let sender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
                                let newMessage = Message(sender: sender, body: messageBody)
                                self.messages.append(newMessage)
                            }
                        }
                    }
                }
            }
    }
    
    
    func sendMessage() {
        if let messageSender = Auth.auth().currentUser?.email {
            let messageBody = newMessage
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970 //second from 1/1/1970
            ]) { error in
                if let e = error {
                    print("Error adding document: \(e)")
                } else {
                    print("Successfully saved data")
                    newMessage = ""
                }
            }
        }
    }
}

#Preview {
    ChatView()
}


// MARK: versione che carica i dati una volta
// cambia solo il .getDocuments che diventa .addSnapshotListener
//    func loadMessages() {
//        self.messages = []
//        db.collection(K.FStore.collectionName).getDocuments { querySnapshot, error in
//            if let e = error {
//                print("There was an issue retrieving data from Firestore. \(e)")
//            } else {
//                if let snapshotDocuments = querySnapshot?.documents {
//                    for doc in snapshotDocuments {
//                        let data = doc.data()
//                        if let sender = data[K.FStore.senderField] as? String, let messageBody = data[K.FStore.bodyField] as? String {
//                            let newMessage = Message(sender: sender, body: messageBody)
//                            self.messages.append(newMessage)
//                        }
//                    }
//                }
//            }
//        }
//    }
