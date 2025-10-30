//
//  GlisexabApp.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/09/25.
//

import SwiftUI

@main
struct GlisexabApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject private var router = NavigationRouter()
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
                .environmentObject(appState)
        }
    }
}
