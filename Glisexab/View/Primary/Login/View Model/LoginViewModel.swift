//
//  LoginViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    
    @Published var mobile: String = ""
    @Published var password: String = ""
    @Published var mobileCode: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var user: Res_LoginResponse?
    
    func login() async {
        isLoading = true
        errorMessage = nil
        
        do {
            var param: [String : Any] = [:]
            param["mobile"] = mobile
            param["password"] = password
            param["mobile_witth_country_code"] = "\(mobileCode)\(mobile)"
            param["register_id"] = ""
            param["ios_register_id"] = ""
            param["type"] = "USER"
            param["lat"] = "0.0"
            param["lon"] = "0.0"
            
            print(param)
            
            let result = try await Api.shared.login(params: param)
            self.user = result
            print("✅ Login Success:", result)
        } catch let apiError as ApiError {
            errorMessage = apiError.localizedDescription
            print("❌ API Error:", apiError.localizedDescription)
        } catch {
            errorMessage = error.localizedDescription
            print("❌ API Error:", error.localizedDescription)
        }
        
        isLoading = false
    }
}
