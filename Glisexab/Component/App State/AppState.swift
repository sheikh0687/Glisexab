//
//  AppState.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import SwiftUI
internal import Combine

enum AppStorageKey: String {
    case isLoggedIn
}

final class AppState: ObservableObject {
    @AppStorage(AppStorageKey.isLoggedIn.rawValue) var isLoggedIn: Bool = false
}
