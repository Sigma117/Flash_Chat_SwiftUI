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
    
    // Navigation
    @EnvironmentObject var shared: NavigationManager
    
    // Firebase
    @EnvironmentObject var authManager: AuthManager
    @State private var firestoreMassageManager = FirestoreMessageManager()
    
    
    // Alert, Button, Keyboard
    @State private var isKeyboardPresent: Bool = false
    @State private var showAlert: Bool = false
    @State private var errorMessage: String?
    @FocusState private var isFocused: Bool
    
    @State private var newMessage: String = ""
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
                            firestoreMassageManager.sendMessage(newMessage) { error in
                                if let e = error {
                                    errorMessage = e.localizedDescription
                                    showAlert = true
                                } else {
                                    print("Successfully saved data")
                                }
                            }
                            newMessage = ""
                        }
                    } label: {
                        Image(systemName: "paperplane")
                    }
                }.padding()
            }
        }
        .onAppear() {
            firestoreMassageManager.loadMessages { messages, error  in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.messages = messages
                }
            }
        }
        .onTapGesture {
            isFocused = false
        }.gesture(
            DragGesture().onChanged { _ in
                isFocused = false
            }
        ).alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if let errorLogOut = authManager.logOutUser() {
                        showAlert = true
                        errorMessage = errorLogOut.localizedDescription
                    }
                    shared.path = NavigationPath()
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                }
            }
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

