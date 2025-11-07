//
//  VehicleList.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 03/11/25.
//

import Foundation

struct Api_VehicleList: Codable {
    let result: [Res_VehicleList]?
    let message: String?
    let status: String?
}

struct Res_VehicleList: Codable, Identifiable {
    let vehicleId: String?
    let vehicle: String?
    let image: String?
    let status: String?
    let no_of_bag: String?
    let date_time: String?
    let base_fair: String?
    let per_hour: String?
    let per_minute: String?
    let per_minute_waiting_charge: String?
    let rush_hour_start_time: String?
    let rush_hour_end_time: String?
    let rush_hour_price: String?
    let per_km_price: String?
    let type: String?
    let no_of_passenger: String?
    let list_order: String?
    let timer_free_minute: String?
    let each_minute_charge: String?
    let stop_Timer_Free_Minute: String?
    let stop_Timer_Per_Min_Charge: String?
    let hourly_rate: String?
    let driver_earning_percentage: String?
    let no_show_fee: String?
    let cancelation_fee: String?
    let booking_fee: String?
    let web_Stop_Price: String?
    let safety_fee: String?
    let airport_fee: String?
    let vehicle_added: String?
    
    // Use CodingKeys only if the JSON key differs in casing or naming,
    // here mostly PascalCase or snake_case with some uppercase,
    // so map appropriately for those keys.
    
    enum CodingKeys: String, CodingKey {
        case vehicleId, vehicle, image, status, no_of_bag, date_time, base_fair, per_hour, per_minute,
             per_minute_waiting_charge, rush_hour_start_time, rush_hour_end_time, rush_hour_price,
             per_km_price, type, no_of_passenger, list_order, timer_free_minute, each_minute_charge,
             stop_Timer_Free_Minute = "Stop_Timer_Free_Minute",
             stop_Timer_Per_Min_Charge = "Stop_Timer_Per_Min_Charge",
             hourly_rate, driver_earning_percentage, no_show_fee, cancelation_fee, booking_fee,
             web_Stop_Price = "Web_Stop_Price", safety_fee, airport_fee, vehicle_added
    }
    
    // Provide non-optional id for Identifiable
    var id: String {
        vehicleId ?? UUID().uuidString
    }
}
