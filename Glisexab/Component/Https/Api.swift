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
    
    private init() {}
    
    func requestToLogin(params: [String: Any], completion: @escaping (Result<Res_LoginResponse, ApiError>) -> Void) {
        Service.shared.request(
            url: Router.login.url(),
            method: .get,
            params: params,
            responseType: LoginResponse.self
        ) { result in
            switch result {
            case .success(let response):
                if response.status == "1", let data = response.result {
                    completion(.success(data))
                } else {
                    completion(.failure(.serverError(response.message ?? "Login failed")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestToSignUp(params: [String: Any], completion: @escaping (Result<Res_LoginResponse, ApiError>) -> Void) {
        Service.shared.request(
            url: Router.signup.url(),
            method: .get,
            params: params,
            responseType: LoginResponse.self
        ) { result in
            switch result {
            case .success(let response):
                if response.status == "1", let data = response.result {
                    completion(.success(data))
                } else {
                    completion(.failure(.serverError(response.message ?? "Sign Up failed")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestToForgetPassword(params: [String: Any], completion: @escaping (Result<Api_ForgetPassword, ApiError>) -> Void) {
        Service.shared.request (
            url: Router.forgot_password.url(),
            method: .get,
            params: params,
            responseType: Api_ForgetPassword.self
        ) { result in
            switch result {
            case .success(let response):
                if response.result != nil {
                    completion(.success(response))
                } else {
                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestToFetchProfile(params: [String: Any], completion: @escaping (Result<Res_LoginResponse, ApiError>) -> Void) {
        Service.shared.request (
            url: Router.get_profile.url(),
            method: .get,
            params: params,
            responseType: LoginResponse.self
        ) { result in
            switch result {
            case .success(let response):
                if response.status == "1", let data = response.result {
                    completion(.success(data))
                } else {
                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func requestToFetchVehicle(params: [String: Any], completion: @escaping (Result<[Res_VehicleList], ApiError>) -> Void) {
        Service.shared.request (
            url: Router.vehicle_list.url(),
            method: .get,
            params: params,
            responseType: Api_VehicleList.self
        ) { result in
            switch result {
            case .success(let response):
                if response.status == "1", let data = response.result {
                    completion(.success(data))
                } else {
                    completion(.failure(.serverError(response.message ?? "Forget password failed")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
