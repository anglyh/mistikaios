//
//  Event.swift
//  mistikaios
//
//  Created by David Quispe Maqque on 11/11/24.
//

import Foundation
struct Event: Codable {
    let id: String
    let title: String
    let description: String
    let date: Date
    let location: Location
    let price: Int
    let capacity: Int
    let imageUri: String
    let tags: [String]
    let isRecommended: Bool
    
    struct Location: Codable {
        let address: String
        let coordinates: [Double]
    }
}
