//
//  AddAddress.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 07/11/25.
//

import Foundation

struct Api_AddAddress : Codable {
    let result : Res_AddAddress?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_AddAddress.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_AddAddress : Codable, Identifiable {
    let id : String?
    let user_id : String?
    let address : String?
    let lat : String?
    let lon : String?
    let addresstype : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_id = "user_id"
        case address = "address"
        case lat = "lat"
        case lon = "lon"
        case addresstype = "addresstype"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lon = try values.decodeIfPresent(String.self, forKey: .lon)
        addresstype = try values.decodeIfPresent(String.self, forKey: .addresstype)
    }
}
