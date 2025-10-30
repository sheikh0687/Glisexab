//
//  ApiService.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import Foundation
import Alamofire

struct ApiService {
    public static let shared = ApiService()

    func callCreateLogin(queryItems: [URLQueryItem]? = nil, parameters: Parameters? = nil, success: @escaping (_ result: LoginResponse?) -> Void, failure: @escaping (_ failureMsg: FailureMessage) -> Void) {
        var headers = HTTPHeaders()
        headers["content-type"] = "application/json"

        ApiManager.shared.callAPI(strURL: Router.login.url(), queryItems: queryItems, method: .post, headers: headers, parameters: parameters, success: { response in
            do {
                if let data = response.data {
                    let createLoginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                    success(createLoginResponse)
                }
            } catch {
                failure(FailureMessage(error.localizedDescription))
            }

        }, failure: { error in
            failure(FailureMessage(error))
        })
    }
}
