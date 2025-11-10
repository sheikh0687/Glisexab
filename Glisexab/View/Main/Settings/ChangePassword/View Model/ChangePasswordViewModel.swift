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
    
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    
    @Published var customError: CustomError? = nil
    
    func requestChangePassword(appState: AppState) {
        
        guard validateFields() else { return }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        paramDict["old_password"] = currentPassword
        paramDict["password"] = newPassword
        
        print(paramDict)
        
        Api.shared.requestToChangePassword(params: paramDict) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success( _):
                    self.isSuccess = true
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func validateFields() -> Bool {
        if currentPassword.isEmpty {
            customError = .customError(message: "Please enter the current passowrd.")
            return false
        } else if newPassword.isEmpty {
            customError = .customError(message: "Please enter the new password.")
            return false
        } else if confirmPassword.isEmpty {
            customError = .customError(message: "Please confirm the new password.")
            return false
        } else if newPassword != confirmPassword {
            customError = .customError(message: "Password mismatch. Please confirm the same passowrd.")
            return false
        }
        return true
    }
}
