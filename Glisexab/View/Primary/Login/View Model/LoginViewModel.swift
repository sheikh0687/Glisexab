//
//  LoginViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import Foundation
import SwiftUI
internal import Combine

class LoginViewModel: ObservableObject {
    
    @Published var txtMobileNum: String = ""
    @Published var txtPassword: String = ""
    @Published var txtMobileCode: String = ""
    
    var cloSuccessRes: (() -> Void)?
    
    func createLogin() {
        
        var paramDict: [String : Any] = [:]
        paramDict["mobile"]                       = txtMobileNum
        paramDict["mobile_witth_country_code"]    = txtMobileCode
        paramDict["password"]                     = txtPassword
        paramDict["register_id"]                  = "" as AnyObject
        paramDict["lat"]                          = "" as AnyObject
        paramDict["lon"]                          = "" as AnyObject
        paramDict["ios_register_id"]              = "" as AnyObject
        paramDict["type"]                         = "" as AnyObject

        print(paramDict)
        
        ApiService.shared.callCreateLogin(parameters: paramDict) { response in
            if let response = response {
                print(response)
                self.cloSuccessRes?()
            }
        }
        failure: { error in
            print(error)
        }
    }
}
