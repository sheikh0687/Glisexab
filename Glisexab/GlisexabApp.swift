//
//  GlisexabApp.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/09/25.
//

import SwiftUI

@main
struct GlisexabApp: App {
    
    @StateObject private var router = NavigationRouter()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(router)
        }
    }
}
