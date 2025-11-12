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
    
    // MARK: PROPERTIES
    @Published var vehicleList: [Res_VehicleList] = []
    @Published var savedCardList: [Cards] = []
    
    @Published var isLoading: Bool = false
    @Published var isBookingForOther: Bool = false
    
    @Published var customError: CustomError? = nil
    @Published var selectedVehcileIndex: String? = nil
    @Published var selectedCardId: String? = nil
    
    @Published var otherName: String = ""
    @Published var otherMobile: String = ""
    @Published var vehicleiD: String = ""
    @Published var vehicleName: String = ""
    @Published var fairEstimate: String = ""
    @Published var cardId: String = ""
    @Published var dateTime: String = ""
    @Published var distance: String = ""
    @Published var paymentType: String = ""
    @Published var paymentStatus: String = ""
    
    @Published var data: BookingDetailData?
    
    @Published var isSuccessBooked: Bool = false
    
    init(data: BookingDetailData? = nil) {
        self.data = data
    }
    
    // MARK: API VEHICLE LIST
    func fetchVehicleList(appState: AppState) {
        guard !appState.useriD.isEmpty else {
            print("⚠️ No user ID found in AppState.")
            return
        }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        paramDict["pick_address"] = data?.pickup.address ?? ""
        paramDict["pickup_lat"] = data?.pickup.latitude ?? ""
        paramDict["pickup_lon"] = data?.pickup.longitude ?? ""
        
        paramDict["drop_address"] = data?.dropoff.address ?? ""
        paramDict["dropoff_lat"] = data?.dropoff.latitude ?? ""
        paramDict["dropoff_lon"] = data?.dropoff.longitude ?? ""
        
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
    
    // MARK: API CARD LIST
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
    
    // MARK: API ADD REQUEST
    func requestAddNearbyReq(appState: AppState, bookingType: String, scheduleDate: String, scheduleTime: String, description: String) {
        guard validateFields() else { return }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        paramDict["vehicle_id"] = vehicleiD
        paramDict["vehicle_name"] = vehicleName
        paramDict["booking_type"] = bookingType
        paramDict["timezone"] = localTimeZoneIdentifier
        paramDict["distance"] = distance
        paramDict["guest_name"] = otherName
        paramDict["guest_mobile"] = otherMobile
        paramDict["book_for_others"] = isBookingForOther ? "Yes" : "No"
        paramDict["pick_address"] = data?.pickup.address ?? ""
        paramDict["pickup_lat"] = data?.pickup.latitude ?? ""
        paramDict["pickup_lon"] = data?.pickup.longitude ?? ""
        paramDict["drop_address"] = data?.dropoff.address ?? ""
        paramDict["dropoff_lat"] = data?.dropoff.address ?? ""
        paramDict["dropoff_lon"] = data?.dropoff.address ?? ""
        paramDict["payment_status"] = paymentStatus
        paramDict["payment_type"] = paymentType
        paramDict["total_amount"] = fairEstimate
        paramDict["card_id"] = cardId
        paramDict["cust_id"] = appState.cardiD
        paramDict["date_time"] = dateTime
        paramDict["date"] = scheduleDate
        paramDict["time"] = scheduleTime
        paramDict["ride_time_price"] = ""
        paramDict["ride_time"] = ""
        paramDict["request_add_time"] = ""
        paramDict["request_type"] = ""
        paramDict["description"] = description
        paramDict["admin_commission"] = ""
        paramDict["driver_amount"] = ""
        paramDict["guest_email"] = ""
        
        print(paramDict)
        
        Api.shared.requestToAddNewRequest(params: paramDict) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success( _):
                    self.isSuccessBooked = true
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: VALIDATE THE FIELDS
    func validateFields() -> Bool {
        if isBookingForOther {
            if otherName.isEmpty || otherMobile.isEmpty {
                customError = .customError(message: "Please enter the other person's name and mobile number.")
                return false
            }
        }
        
        if vehicleiD.isEmpty {
            customError = .customError(message: "Please select a vehicle.")
            return false
        }
        
//        if cardId.isEmpty {
//            customError = .customError(message: "Please select a card.")
//            return false
//        }
        
        return true
    }
}
