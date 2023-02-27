//
//  Order.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

import Foundation

struct Order{
    let date: String
    let address: String
    let price: Int
    let card_number: String
    let details: [String: [String: String]]
}
