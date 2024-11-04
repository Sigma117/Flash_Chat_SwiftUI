//
//  NaviagationController.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import Foundation
import SwiftUI

enum NavigationDestination: Hashable {
    case welcomeView
    case registrationView
    case loginView
    case chatView
}

// MARK: - Navigation Manager
class NavigationManager: ObservableObject {
    @Published var navigationPath = NavigationPath()
    
    // Push a new view onto the navigation stack
    func push(_ destination: NavigationDestination) {
        navigationPath.append(destination)
    }
    
    // Pop the top view from the navigation stack
    func pop() {
        if !navigationPath.isEmpty {
            navigationPath.removeLast()
        }
    }
    
    // Clear all views from the navigation stack
    func reset() {
        navigationPath = NavigationPath()
    }

}
