//
//  Food.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import Foundation

struct FoodResponse: Codable{
    let foods: [Food]
    enum CodingKeys: String,CodingKey{
        case foods = "yemekler"
    }
}

struct Food: Codable{
    
    let foodId: String
    let foodName: String
    let foodImageName: String
    let foodPrice: String
    var foodImageURL: String?
    var didLike: Bool = false
    
    enum CodingKeys: String,CodingKey{
        case foodId = "yemek_id"
        case foodName = "yemek_adi"
        case foodImageName = "yemek_resim_adi"
        case foodPrice = "yemek_fiyat"
        case foodImageURL = "foodImageURL"
    }
}

