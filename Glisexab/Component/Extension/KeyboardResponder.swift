//
//  KeyboardResponder.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 29/10/25.
//

import SwiftUI
internal import Combine

class KeyboardResponder: ObservableObject {
    
    @Published var keyboardShown: Bool = false

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .map { _ in true }
            .assign(to: \.keyboardShown, on: self)
            .store(in: &cancellableSet)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false }
            .assign(to: \.keyboardShown, on: self)
            .store(in: &cancellableSet)
    }
}
