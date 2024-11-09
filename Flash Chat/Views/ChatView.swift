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
    @State private var isKeyboardPresent: Bool = false
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
                }.onChange(of: messages) { _, _ in
                    if let last = messages.last {
                        scroolToBottom(proxy, last)
                    }
                }.onReceive(keyboardPublisher) { value in
                    if value == true {
                        if let last = messages.last {
                            scroolToBottom(proxy, last)
                        }
                    }
                }
                
                HStack {
                    TextField("Send a message", text: $newMessage)
                        .textFieldStyle(.roundedBorder)
                        .focused($isFocused)
                    Button {
                        DispatchQueue.main.async {
                            sendMessage()
                        }
                        
                    } label: {
                        Image(systemName: "paperplane")
                    }
                }.padding()
            }
        }
        .onAppear() {
            loadMessages()
        }
        .onTapGesture {
            isFocused = false
        }.gesture(
            DragGesture().onChanged { _ in
                isFocused = false
            }
        ).toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    logout()
                    shared.path = NavigationPath()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
            }
        }
        
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
            newMessage = "" // is here and not after the else because, other wise we need to wait for the firestore before cleaning the TextField
            
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970 //second from 1/1/1970
            ]) { error in
                if let e = error {
                    print("Error adding document: \(e)")
                } else {
                    print("Successfully saved data")
                }
            }
        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
    
    func scroolToBottom(_ proxy: ScrollViewProxy, _ last: Message) {
        withAnimation{
            proxy.scrollTo(last, anchor: .bottom)
        }
    }
}

extension View {
    
    var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .Merge(
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .map { _ in true },
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillHideNotification)
                    .map { _ in false })
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
}

#Preview {
    ChatView()
}

