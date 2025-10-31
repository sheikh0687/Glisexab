//
//  Api.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 31/10/25.
//

import Foundation
import Alamofire

final class Api {
    static let shared = Api()
    
    func login(params: [String: Any]) async throws -> Res_LoginResponse {
        let response: LoginResponse = try await Service.shared.request (
            url: Router.login.url(),
            method: .get,
            params: params,
            responseType: LoginResponse.self
        )
        guard response.status == "1", let result = response.result else {
            throw ApiError.serverError(response.message ?? "Login failed")
        }
        return result
    }
    
    func signUp(params: [String : Any]) async throws -> Res_LoginResponse {
        let response: LoginResponse = try await Service.shared.request (
            url: Router.signUp.url(),
            method: .get,
            params: params,
            responseType: LoginResponse.self
        )
        guard response.status == "1", let result = response.result else {
            throw ApiError.serverError(response.message ?? "Sign Up failed")
        }
        
        return result
    }
}
