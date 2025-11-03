//
//  VehicleList.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 03/11/25.
//

import Foundation

struct Api_VehicleList : Codable {
    let result : [Res_VehicleList]?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent([Res_VehicleList].self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_VehicleList : Codable {
    let id : String?
    let vehicle : String?
    let image : String?
    let status : String?
    let no_of_bag : String?
    let date_time : String?
    let base_fair : String?
    let per_hour : String?
    let per_minute : String?
    let per_minute_waiting_charge : String?
    let rush_hour_start_time : String?
    let rush_hour_end_time : String?
    let rush_hour_price : String?
    let per_km_price : String?
    let type : String?
    let no_of_passenger : String?
    let list_order : String?
    let timer_free_minute : String?
    let each_minute_charge : String?
    let stop_Timer_Free_Minute : String?
    let stop_Timer_Per_Min_Charge : String?
    let hourly_rate : String?
    let driver_earning_percentage : String?
    let no_show_fee : String?
    let cancelation_fee : String?
    let booking_fee : String?
    let web_Stop_Price : String?
    let safety_fee : String?
    let airport_fee : String?
    let vehicle_added : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case vehicle = "vehicle"
        case image = "image"
        case status = "status"
        case no_of_bag = "no_of_bag"
        case date_time = "date_time"
        case base_fair = "base_fair"
        case per_hour = "per_hour"
        case per_minute = "per_minute"
        case per_minute_waiting_charge = "per_minute_waiting_charge"
        case rush_hour_start_time = "rush_hour_start_time"
        case rush_hour_end_time = "rush_hour_end_time"
        case rush_hour_price = "rush_hour_price"
        case per_km_price = "per_km_price"
        case type = "type"
        case no_of_passenger = "no_of_passenger"
        case list_order = "list_order"
        case timer_free_minute = "timer_free_minute"
        case each_minute_charge = "each_minute_charge"
        case stop_Timer_Free_Minute = "Stop_Timer_Free_Minute"
        case stop_Timer_Per_Min_Charge = "Stop_Timer_Per_Min_Charge"
        case hourly_rate = "hourly_rate"
        case driver_earning_percentage = "driver_earning_percentage"
        case no_show_fee = "no_show_fee"
        case cancelation_fee = "cancelation_fee"
        case booking_fee = "booking_fee"
        case web_Stop_Price = "Web_Stop_Price"
        case safety_fee = "safety_fee"
        case airport_fee = "airport_fee"
        case vehicle_added = "vehicle_added"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        vehicle = try values.decodeIfPresent(String.self, forKey: .vehicle)
        image = try values.decodeIfPresent(String.self, forKey: .image)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        no_of_bag = try values.decodeIfPresent(String.self, forKey: .no_of_bag)
        date_time = try values.decodeIfPresent(String.self, forKey: .date_time)
        base_fair = try values.decodeIfPresent(String.self, forKey: .base_fair)
        per_hour = try values.decodeIfPresent(String.self, forKey: .per_hour)
        per_minute = try values.decodeIfPresent(String.self, forKey: .per_minute)
        per_minute_waiting_charge = try values.decodeIfPresent(String.self, forKey: .per_minute_waiting_charge)
        rush_hour_start_time = try values.decodeIfPresent(String.self, forKey: .rush_hour_start_time)
        rush_hour_end_time = try values.decodeIfPresent(String.self, forKey: .rush_hour_end_time)
        rush_hour_price = try values.decodeIfPresent(String.self, forKey: .rush_hour_price)
        per_km_price = try values.decodeIfPresent(String.self, forKey: .per_km_price)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        no_of_passenger = try values.decodeIfPresent(String.self, forKey: .no_of_passenger)
        list_order = try values.decodeIfPresent(String.self, forKey: .list_order)
        timer_free_minute = try values.decodeIfPresent(String.self, forKey: .timer_free_minute)
        each_minute_charge = try values.decodeIfPresent(String.self, forKey: .each_minute_charge)
        stop_Timer_Free_Minute = try values.decodeIfPresent(String.self, forKey: .stop_Timer_Free_Minute)
        stop_Timer_Per_Min_Charge = try values.decodeIfPresent(String.self, forKey: .stop_Timer_Per_Min_Charge)
        hourly_rate = try values.decodeIfPresent(String.self, forKey: .hourly_rate)
        driver_earning_percentage = try values.decodeIfPresent(String.self, forKey: .driver_earning_percentage)
        no_show_fee = try values.decodeIfPresent(String.self, forKey: .no_show_fee)
        cancelation_fee = try values.decodeIfPresent(String.self, forKey: .cancelation_fee)
        booking_fee = try values.decodeIfPresent(String.self, forKey: .booking_fee)
        web_Stop_Price = try values.decodeIfPresent(String.self, forKey: .web_Stop_Price)
        safety_fee = try values.decodeIfPresent(String.self, forKey: .safety_fee)
        airport_fee = try values.decodeIfPresent(String.self, forKey: .airport_fee)
        vehicle_added = try values.decodeIfPresent(String.self, forKey: .vehicle_added)
    }

}

