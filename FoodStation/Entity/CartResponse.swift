//
//  CartResponse.swift
//  FoodStation
//
//  Created by admin on 7.02.2023.
//

import Foundation

struct CartResponse: Codable{
    
    let success: Int
    let message: String?
    let cart: [FoodInCart]?
    
    enum CodingKeys: String, CodingKey{
        case cart = "sepet_yemekler"
        case success = "success"
        case message = "message"
    }
}

struct FoodInCart: Codable{
    
    let foodIDInCart: String
    let foodName: String
    let foodImageName: String
    let foodPrice: String
    let foodAmount: String
    let username: String
    
    enum CodingKeys: String, CodingKey{
        case foodIDInCart = "sepet_yemek_id"
        case foodName = "yemek_adi"
        case foodImageName = "yemek_resim_adi"
        case foodPrice = "yemek_fiyat"
        case foodAmount = "yemek_siparis_adet"
        case username = "kullanici_adi"
    }
}
