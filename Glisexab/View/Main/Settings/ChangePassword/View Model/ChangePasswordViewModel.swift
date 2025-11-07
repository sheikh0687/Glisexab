//
//  ChangePasswordViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 06/11/25.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
class ChangePasswordViewModel: ObservableObject {
    
    @Published var currentPassword: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""
}
