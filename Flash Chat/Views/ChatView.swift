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
    @State private var firestoreMessageManager = FirestoreMessageManager()
    
    
    // Alert, Button, Keyboard
    @State private var isKeyboardPresent: Bool = false
    @State private var showAlert: Bool = false
    @State private var errorMessage: String?
    @FocusState private var isFocused: Bool
    
    @State private var newMessage: String = ""
    @State private var messages: [Message] = []
    
    var body: some View {
        
        VStack {
            
            ScrollMessagesView(messages: $messages)
            InputMessageBar(newMessage: $newMessage, isFocused: $isFocused) {
                DispatchQueue.main.async {
                    firestoreMessageManager.sendMessage(newMessage) { error in
                        if let e = error {
                            errorMessage = e.localizedDescription
                            showAlert = true
                        }
                    }
                    newMessage = ""
                }
            }
        }
        .onAppear() {
            firestoreMessageManager.loadMessages { messages, error  in
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
            })
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text(errorMessage ?? "Unknown error"), dismissButton: .default(Text("OK")))
        }
        .toolbar {toolbarLogOut}
    }
    
    
    
    private var toolbarLogOut: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                if let errorLogOut = authManager.logOutUser() {
                    errorMessage = errorLogOut.localizedDescription
                    showAlert = true
                } else {
                    shared.path = NavigationPath()
                }
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
            }
        }
    }
}



#Preview {
    ChatView()
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
