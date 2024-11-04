//
//  ModifierTextStyle.swift
//  PlainParty
//
//  Created by Stefano Zhao on 04/11/24.
//

import SwiftUI

struct ModifierTextStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .fontWeight(.bold)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
    }
}
