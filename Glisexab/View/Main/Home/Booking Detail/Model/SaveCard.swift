//
//  SaveCard.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 04/11/25.
//

import Foundation

struct Api_CardList : Codable {
    let result : Res_CardList?
    let message : String?
    let status : String?

    enum CodingKeys: String, CodingKey {
        case result = "result"
        case message = "message"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        result = try values.decodeIfPresent(Res_CardList.self, forKey: .result)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

struct Res_CardList : Codable {
    let cards : [Cards]?

    enum CodingKeys: String, CodingKey {
        case cards = "cards"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cards = try values.decodeIfPresent([Cards].self, forKey: .cards)
    }
}

struct Cards : Codable, Identifiable {
    let cardId : String?
    let card_brand : String?
    let last_4 : String?
    let exp_month : Int?
    let exp_year : Int?
    let cardholder_name : String?
    let billing_address : Billing_address?
    let fingerprint : String?
    let customer_id : String?
    let merchant_id : String?
    let enabled : Bool?
    let card_type : String?
    let prepaid_type : String?
    let bin : String?
    let created_at : String?
    let version : Int?
    
    var id: String {
        cardId ?? UUID().uuidString
    }
    
    enum CodingKeys: String, CodingKey {

        case cardId = "id"
        case card_brand = "card_brand"
        case last_4 = "last_4"
        case exp_month = "exp_month"
        case exp_year = "exp_year"
        case cardholder_name = "cardholder_name"
        case billing_address = "billing_address"
        case fingerprint = "fingerprint"
        case customer_id = "customer_id"
        case merchant_id = "merchant_id"
        case enabled = "enabled"
        case card_type = "card_type"
        case prepaid_type = "prepaid_type"
        case bin = "bin"
        case created_at = "created_at"
        case version = "version"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cardId = try values.decodeIfPresent(String.self, forKey: .cardId)
        card_brand = try values.decodeIfPresent(String.self, forKey: .card_brand)
        last_4 = try values.decodeIfPresent(String.self, forKey: .last_4)
        exp_month = try values.decodeIfPresent(Int.self, forKey: .exp_month)
        exp_year = try values.decodeIfPresent(Int.self, forKey: .exp_year)
        cardholder_name = try values.decodeIfPresent(String.self, forKey: .cardholder_name)
        billing_address = try values.decodeIfPresent(Billing_address.self, forKey: .billing_address)
        fingerprint = try values.decodeIfPresent(String.self, forKey: .fingerprint)
        customer_id = try values.decodeIfPresent(String.self, forKey: .customer_id)
        merchant_id = try values.decodeIfPresent(String.self, forKey: .merchant_id)
        enabled = try values.decodeIfPresent(Bool.self, forKey: .enabled)
        card_type = try values.decodeIfPresent(String.self, forKey: .card_type)
        prepaid_type = try values.decodeIfPresent(String.self, forKey: .prepaid_type)
        bin = try values.decodeIfPresent(String.self, forKey: .bin)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        version = try values.decodeIfPresent(Int.self, forKey: .version)
    }
    
}

struct Billing_address : Codable {
    let postal_code : String?

    enum CodingKeys: String, CodingKey {
        case postal_code = "postal_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        postal_code = try values.decodeIfPresent(String.self, forKey: .postal_code)
    }
}
