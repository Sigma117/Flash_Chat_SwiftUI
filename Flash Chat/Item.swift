//
//  Item.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
