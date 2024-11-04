//
//  ModifierTextFieldStyle.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import SwiftUI

struct ModifierTextFieldStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
    }
}
