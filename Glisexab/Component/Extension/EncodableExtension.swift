//
//  EncodableExtension.swift
//  Glisexab
//
//  Created by Techimmense Software Solutions on 30/10/25.
//

import Foundation

// Converts encodable structure to dictionary.
extension Encodable {
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
