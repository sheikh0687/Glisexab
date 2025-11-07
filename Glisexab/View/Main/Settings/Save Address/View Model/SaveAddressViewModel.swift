//
//  SaveAddressViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 06/11/25.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
class SaveAddressViewModel: ObservableObject {
    
    @Published var arrayOfAddress: [Res_InfoAddress] = []
    
    @Published var isLoading: Bool = false
    @Published var customError: CustomError? = nil
    
    @Published var cloDeleteAddres: (() -> Void)?
    
    func fetchSavedAddressList(appState: AppState) {
        
        guard !appState.useriD.isEmpty else {
            print("⚠️ No user ID found in AppState.")
            return
        }

        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        
        print(paramDict)
        
        Api.shared.requestToSaveAddressList(params: paramDict) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let res):
                    self.arrayOfAddress = res
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func deleteUserSavedAddress(appState: AppState, addressiD: String) {
        guard !appState.useriD.isEmpty else {
            print("⚠️ No user ID found in AppState.")
            return
        }

        isLoading = true
        customError = nil

        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        paramDict["address_id"] = addressiD
        
        print(paramDict)
        
        Api.shared.requestToDeleteAddress(params: paramDict) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success( _):
                    self.cloDeleteAddres?()
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
}
