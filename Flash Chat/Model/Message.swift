//
//  Message.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 05/11/24.
//

import Foundation

struct Message: Hashable {
    let id: UUID = UUID()
    let sender: String // contain the sendere email
    let body: String // contain the message
}
