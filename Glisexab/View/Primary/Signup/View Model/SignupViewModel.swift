//
//  SignupViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 31/10/25.
//

internal import Combine
import SwiftUI

@MainActor
final class SignupViewModel: ObservableObject {
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var email: String = ""
    @Published var mobile: String = ""
    @Published var mobileCode: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var newUser: Res_LoginResponse?
    
    private let locationManager = LocationSearchViewModel()
    @Published var locationError: LocationError?
    
    @Published var address: String = ""
    @Published var city: String?
    @Published var state: String?
    @Published var latitude: Double?
    @Published var longitude: Double?
    
    @Published var customError: CustomError? = nil
    
    @Published var isCheck = false
    
    func webRegisterUser() {
        
        guard validateFields() else { return }
        
        isLoading = true
        errorMessage = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["first_name"] = firstName
        paramDict["last_name"] = lastName
        paramDict["mobile"] = mobile
        paramDict["mobile_witth_country_code"] = "\(mobileCode)\(mobile)"
        paramDict["email"] = email
        paramDict["address"] = address
        paramDict["register_id"] = ""
        paramDict["ios_register_id"] = ""
        paramDict["type"] = "USER"
        paramDict["lat"] = latitude
        paramDict["lon"] = longitude

        print(paramDict)

        Api.shared.requestToSignUp(params: paramDict) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let res):
                    self.newUser = res
                    print("✅ Registration Success:", res)
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                    print("❌ API Error:", error.localizedDescription)
                }
            }
        }
    }
    
    func validateFields() -> Bool {
        if firstName.isEmpty {
            customError = .customError(message: "Please enter your first name.")
            return false
        } else if lastName.isEmpty {
            customError = .customError(message: "Please enter your last name.")
            return false
        } else if email.isEmpty {
            customError = .customError(message: "Please enter your valid email address.")
            return false
        } else if mobile.isEmpty {
            customError = .customError(message: "Please enter your mobile number.")
            return false
        } else if address.isEmpty {
            customError = .customError(message: "Please select your address.")
            return false
        } else if password.isEmpty {
            customError = .customError(message: "Please enter the password.")
            return false
        } else if confirmPassword.isEmpty {
            customError = .customError(message: "Please confirm the password.")
            return false
        } else if password != confirmPassword {
            customError = .customError(message: "Password mismatch. Please enter the same password.")
            return false
        } else if isCheck == false {
            customError = .customError(message: "Please read the terms and conditions.")
            return false
        }
        return true
    }
    
    func requestForLocationServices() {
        locationManager.getLocation { result in
            switch result {
            case .success(let location):
                self.locationError = nil
//                Console.log("Got location: \(location)")
                self.address = location.address ?? ""
                self.city = location.city ?? ""
                self.state = location.state ?? ""
                self.latitude = location.latitude ?? 0.0
                self.longitude = location.longitude ?? 0.0
            case .failure(let error):
//                Console.log("Error: \(error.userMessage)")
                self.locationError = error
            }
        }
    }

}
