//
//  ScrollMessagesView.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 11/11/24.
//

import SwiftUI

struct ScrollMessagesView: View {
    
    @Binding var messages: [Message]
    
    var body: some View {
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
        }
    }
    
    func scroolToBottom(_ proxy: ScrollViewProxy, _ last: Message) {
        withAnimation{
            proxy.scrollTo(last, anchor: .bottom)
        }
    }
}

#Preview {
    ScrollMessagesView(messages: .constant([Message(sender: "@.com", body: "Test"), Message(sender: "@.com", body: "Test2")]))
}
