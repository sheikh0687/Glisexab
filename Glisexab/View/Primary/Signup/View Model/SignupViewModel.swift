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
    
    @Published var address: String?
    @Published var city: String?
    @Published var state: String?
    @Published var latitude: Double?
    @Published var longitude: Double?
    
    func signUp() async {
        isLoading = true
        errorMessage = nil
        
        do {
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
            
            let result = try await Api.shared.signUp(params: paramDict)
            self.newUser = result
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
