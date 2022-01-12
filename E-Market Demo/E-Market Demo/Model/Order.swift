//
//  Order.swift
//  E-Market Demo
//
//  Created by MAC on 1/10/22.
//

import Foundation

// MARK: - Order
//public struct Order: DictionaryConvertor {
public struct Order: Codable {
    let products: [Product]?
    let deliveryAddress: String?

    enum CodingKeys: String, CodingKey {
        case products
        case deliveryAddress = "delivery_address"
    }
}

// MARK: - Product
//public struct Product: DictionaryConvertor {
public struct Product: Codable {
    let name: String?
    let price: Double?
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case name, price
        case imageURL = "imageUrl"
    }
}
