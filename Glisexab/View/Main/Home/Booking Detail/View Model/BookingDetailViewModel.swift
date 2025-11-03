//
//  BookingDetailViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 03/11/25.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
class BookingDetailViewModel: ObservableObject {
    
    @Published var vehicleList: [Res_VehicleList] = []
    
    @Published var isLoading: Bool = false
    @Published var customError: CustomError? = nil
        
    func fetchVehicleList(appState: AppState)
    {
        guard !appState.useriD.isEmpty else {
            print("⚠️ No user ID found in AppState.")
            return
        }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        
        print(paramDict)
        
        Api.shared.requestToFetchVehicle(params: paramDict) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let res):
                    self.vehicleList = res
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
}
