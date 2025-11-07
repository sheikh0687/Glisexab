//
//  AddAddressViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 07/11/25.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
class AddAddressViewModel: ObservableObject {
    
    @Published var address: String = ""
    @Published var city: String?
    @Published var state: String?
    @Published var latitude: Double?
    @Published var longitude: Double?
    @Published var addressType: String = ""
    
    private let locationManager = LocationSearchViewModel()
    @Published var locationError: LocationError?
    
    @Published var customError: CustomError? = nil
    @Published var isLoading: Bool = false
    
    @Published var isSuccess: Bool = false

    func addUserAddress(appState: AppState) {
        
        guard validateFields() else { return }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        paramDict["address"] = address
        paramDict["lat"] = latitude
        paramDict["lon"] = longitude
        paramDict["addresstype"] = addressType
        
        paramDict["street"] = ""
        paramDict["city"] = ""
        paramDict["pincode"] = ""
        
        print(paramDict)
        
        Api.shared.requestToAddAddress(params: paramDict) { [weak self] result in
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
        if address.isEmpty {
            customError = .customError(message: "Please select address.")
            return false
        } else if addressType.isEmpty {
            customError = .customError(message: "Please enter the address type.")
            return false
        }
        return true
    }

    func requestForLocationServices() {
        locationManager.getLocation { result in
            switch result {
            case .success(let location):
                self.locationError = nil
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
