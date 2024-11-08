//
//  NaviagationController.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import Foundation
import SwiftUI
import Observation

enum NavigationDestination: Hashable {
    case welcomeView
    case registrationView
    case loginView
    case chatView
}

// MARK: - Navigation Manager
class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    static let shared = NavigationManager()
}
