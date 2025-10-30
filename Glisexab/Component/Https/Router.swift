//
//  Router.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import Foundation

enum Router: String {
    
    static let BASE_SERVICE_URL = "https://techimmense.in/glisexab/webservice/"
    static let BASE_IMAGE_URL = "https://techimmense.in/glisexab/uploads/images/"
    
    case login
    case forgetPassword
    case signUp
    
    public func url() -> String {
        switch self {
        case .login:
            return Router.oAuthRoute(path: "login")
        case .signUp:
            return Router.oAuthRoute(path: "signup")
        case .forgetPassword:
            return Router.oAuthRoute(path: "forget_passowrd")
        }
    }
    
    private static func oAuthRoute(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
}
