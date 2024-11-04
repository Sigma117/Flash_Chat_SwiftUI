//
//  Flash_ChatApp.swift
//  Flash Chat
//
//  Created by Stefano Zhao on 04/11/24.
//

import SwiftUI
import SwiftData
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct Flash_ChatApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var navigationManager = NavigationManager()
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
        
            NavigationStack(path: $navigationManager.navigationPath) {
                WelcomeView()
                    .environmentObject(navigationManager)
                    .navigationDestination(for: NavigationDestination.self) { destination in
                        destinationView(for: destination)
                    }
            }
            .modelContainer(sharedModelContainer)
        } 
    }
    private func destinationView(for destination: NavigationDestination) -> some View {
        switch destination {

        case .welcomeView:
            AnyView(WelcomeView())
                .environmentObject(navigationManager)
        case .registrationView:
            AnyView(RegistrationView())
                .environmentObject(navigationManager)
        case .loginView:
            AnyView(LoginView())
                .environmentObject(navigationManager)
        case .chatView:
            AnyView(ChatView())
                .environmentObject(navigationManager)
        }
    }
}
