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
    @Published var savedCardList: [Cards] = []
    
    @Published var isLoading: Bool = false
    @Published var customError: CustomError? = nil
    @Published var selectedVehcileIndex: String? = nil
    @Published var selectedCardId: String? = nil
    
    @Published var data: BookingDetailData?
    
    init(data: BookingDetailData? = nil) {
        self.data = data
    }
    
    func fetchVehicleList(appState: AppState) {
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
                self.isLoading = false
                switch result {
                case .success(let res):
                    self.vehicleList = res
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func fetchSaveCard(appState: AppState) {
        
        guard !appState.useriD.isEmpty else {
            print("⚠️ No user ID found in AppState.")
            return
        }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        paramDict["cust_id"] = appState.cardiD
        
        print(paramDict)
        
        Api.shared.requestToFetchSaveCard(params: paramDict) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let res):
                    if let cardList = res.cards {
                        self.savedCardList = cardList
                    }
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
    
    func requestAddNearbyReq(appState: AppState) {
        
    }
}
