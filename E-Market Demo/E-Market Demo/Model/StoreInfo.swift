//
//  StoreInfo.swift
//  E-Market Demo
//
//  Created by MAC on 1/10/22.
//

import Foundation

// MARK: - Welcome
struct StoreInfo: Codable {
    let name: String?
    let rating: Double?
    let openingTime, closingTime: String?
}
