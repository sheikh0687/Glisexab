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
    case forgot_password
    case signup
    
    case get_profile
    case vehicle_list
    
    public func url() -> String {
        switch self {
        case .login:
            return Router.oAuthRoute(path: "login")
        case .signup:
            return Router.oAuthRoute(path: "signup")
        case .forgot_password:
            return Router.oAuthRoute(path: "forgot_password")
        case .get_profile:
            return Router.oAuthRoute(path: "get_profile")
        case .vehicle_list:
            return Router.oAuthRoute(path: "vehicle_list")
        }
    }
    
    private static func oAuthRoute(path: String) -> String {
        return Router.BASE_SERVICE_URL + path
    }
}
