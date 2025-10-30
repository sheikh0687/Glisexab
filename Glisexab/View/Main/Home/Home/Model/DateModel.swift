//
//  DateModel.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 29/10/25.
//

import Foundation

struct LocationDetail: Hashable {
    let address: String
    let latitude: Double
    let longitude: Double
}

struct BookingDetailData: Hashable {
    let pickup: LocationDetail
    let dropoff: LocationDetail
}
