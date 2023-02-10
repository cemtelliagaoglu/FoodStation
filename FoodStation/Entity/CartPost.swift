//
//  CartPost.swift
//  FoodStation
//
//  Created by admin on 8.02.2023.
//

import Foundation

struct CartPost: Codable{
        
    let foodName: String
    let foodImageName: String
    let foodPrice: Int
    let foodAmount: Int
    let username: String

    enum CodingKeys: String, CodingKey{
        case foodName = "yemek_adi"
        case foodImageName = "yemek_resim_adi"
        case foodPrice = "yemek_fiyat"
        case foodAmount = "yemek_siparis_adet"
        case username = "kullanici_adi"
    }
}
