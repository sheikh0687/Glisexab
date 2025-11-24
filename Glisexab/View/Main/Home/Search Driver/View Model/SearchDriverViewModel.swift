//
//  SearchDriverViewModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 13/11/25.
//

import Foundation
import SwiftUI
internal import Combine

@MainActor
class SearchDriverViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var customError: CustomError? = nil
    @Published var isSuccess: Bool = false
    @Published var obj_Res: Res_UserActiveRequest?
    
    @Published var profileImage: UIImage? = nil
    @Published var vehcileImage: UIImage? = nil
//    @Published var data: BookingDetailData?
//    
//    init(data: BookingDetailData? = nil) {
//        self.data = data
//    }
    
    func userActiveRequest(appState: AppState) {
        guard !appState.useriD.isEmpty else {
            print("No useriD FOund")
            return
        }
        
        isLoading = true
        customError = nil
        
        var paramDict: [String : Any] = [:]
        paramDict["user_id"] = appState.useriD
        
        print("ATIVE REQUEST PARAMETERS: -\(paramDict)")
        
        Api.shared.requestToUserActiveReq(params: paramDict) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success( let res ):
                    self.isSuccess = true
                    self.obj_Res = res
                    
                    Utility.downloadImageBySDWebImage(res.car_details?.image ?? "") { img, error in
                        if let img = img {
                            DispatchQueue.main.async {
                                self.vehcileImage = img
                            }
                        } else if let error = error {
                            print("Image download failed: \(error.localizedDescription)")
                        }
                    }
                    
                case .failure(let error):
                    self.customError = .customError(message: error.localizedDescription)
                }
            }
        }
     }
}
