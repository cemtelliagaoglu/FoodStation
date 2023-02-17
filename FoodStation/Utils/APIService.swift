//
//  APIService.swift
//  FoodStation
//
//  Created by admin on 8.02.2023.
//

import Foundation
import Alamofire

struct APIService{
    
    static func requestAllFoodsInDatabase(completion: @escaping(([Food]?, String?) -> ())){
        let imagesBaseURLString = "http://kasimadalan.pe.hu/yemekler/resimler/"
        let allFoodsURLString = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
        // get food data
        AF.request(allFoodsURLString,method: .get).response{ response in
            if let data = response.data{
                do{
                    let decodedData = try JSONDecoder().decode(FoodResponse.self, from: data)
                    var foods = [Food]()
                    // download food images
                    for var food in decodedData.foods{
                        food.foodImageURL = imagesBaseURLString + food.foodImageName
                        foods.append(food)
                    }
                    completion(foods, nil)
                }catch{
                    completion(nil,error.localizedDescription)
                    print(error)
                }
            }
        }
    }
    
    static func requestUserCartInfo(for currentUser: String,completion: @escaping(([FoodInCart]?) -> ())) {
        // try to load user's cart
        let foodsInCartBaseURL = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
        
        let params = ["kullanici_adi": currentUser]
        AF.request(URL(string: foodsInCartBaseURL)!,method: .post, parameters: params).response(){ response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(CartResponse.self, from: data)
                    completion(response.cart!)
                    print("Success: \(response.success)")
                    for food in response.cart!{
                        print("Sepet ID: \(food.foodIDInCart) - Yemek Ad: \(food.foodName) - Yemek Adet: \(food.foodAmount) - Kullanici Adi: \(food.username)")
                    }
                }catch{
                    completion(nil)
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    static func requestAddToCart(for currentUser: String,food: Food, amount: Int, completion: @escaping((String) -> ())) {
        // check if food exists in the cart, if yes delete from the cart
        // create a new cart with given amount of food
        let addToCartBaseURL = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        
        self.deleteFoodIfInCart(for: currentUser, food)
        if amount > 0{
            
            let params: [String: Any] = ["yemek_adi":food.foodName,"yemek_resim_adi":food.foodImageName, "yemek_fiyat": Int(food.foodPrice)!,"yemek_siparis_adet": amount,"kullanici_adi": currentUser]
            
            AF.request(URL(string: addToCartBaseURL)!,method: .post, parameters: params).response(){ response in
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(CartResponse.self, from: data)
                        if response.success == 1{
                            completion("success")
                        }else{
                            completion(response.message!)
                        }
                        print("Adding to Cart Status: \(response.success == 1 ? "Successfull" : "Failed")")
                    }catch{
                        print(error)
                    }
                }
            }
        }
    }
    
    static func requestAddToCart(for currentUser: String,foodInCart: FoodInCart, amount: Int, completion: @escaping((String) -> ())){
        // delete existing foodInCart,
        // create a new cart with given amount of food
        let addToCartBaseURL = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        
        self.deleteItem(foodIDInCart: Int(foodInCart.foodIDInCart)!, for: currentUser)

        if amount > 0{
            // create new cart with updated amount of food
            let params: [String: Any] = ["yemek_adi":foodInCart.foodName,"yemek_resim_adi":foodInCart.foodImageName, "yemek_fiyat": Int(foodInCart.foodPrice)!,"yemek_siparis_adet": amount,"kullanici_adi": currentUser]
            
            AF.request(URL(string: addToCartBaseURL)!,method: .post, parameters: params).response(){ response in
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(CartResponse.self, from: data)
                        if response.success == 1{
                            completion("success")
                        }else{
                            completion(response.message!)
                        }
                        print("Adding to Cart Status: \(response.success == 1 ? "Successfull" : "Failed")")
                    }catch{
                        print(error)
                    }
                }
            }
        }
    }
    
    static func deleteItem(foodIDInCart: Int, for username: String){
        let baseURL = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
        
        let params: [String:Any] = ["kullanici_adi": username, "sepet_yemek_id": foodIDInCart]
        AF.request(URL(string: baseURL)!,method: .post, parameters: params).response(){ response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(CartResponse.self, from: data)
                    print("Deleting Status: \(response.success == 1 ? "Success": "Failed")")
                }catch{
                    print(error)
                }
            }
        }
    }
    static func deleteFoodIfInCart(for currentUser: String,_ food: Food){
        // if user has added food in the cart previously, delete from cart
        requestUserCartInfo(for: currentUser) { foods in
            
            guard let foods = foods else{ return }
            for foodInDatabase in foods{
                if foodInDatabase.foodName == food.foodName{
                    self.deleteItem(for: currentUser, id: Int(foodInDatabase.foodIDInCart)!)
                }
            }
        }
    }
    
    static func deleteItem(for currentUser: String,id: Int){
        // delete food from cart
        let deleteFoodBaseURL = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
        
        let params: [String:Any] = ["kullanici_adi": currentUser, "sepet_yemek_id": id]
        AF.request(URL(string: deleteFoodBaseURL)!,method: .post, parameters: params).response(){ response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(CartResponse.self, from: data)
                    print("Deleting CartID: \(id)...")
                    print("Deleting: \(response.success == 1 ? "Success": "Failed")")
                }catch{
                    print(error)
                }
            }
        }
    }
    
    static func deleteItem(for currentUser: String,id: Int, completion: @escaping((Error?) -> ())){
        // delete food from cart
        let deleteFoodBaseURL = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
        
        let params: [String:Any] = ["kullanici_adi": currentUser, "sepet_yemek_id": id]
        AF.request(URL(string: deleteFoodBaseURL)!,method: .post, parameters: params).response(){ response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(CartResponse.self, from: data)
                    completion(nil)
                    print("Deleting CartID: \(id)...")
                    print("Deleting: \(response.success == 1 ? "Success": "Failed")")
                }catch{
                    completion(error)
                    print(error)
                }
            }
        }
    }
    
    static func deleteAllCart(for currentUser: String, completion: @escaping((Error?) -> ())){
        requestUserCartInfo(for: currentUser) { cart in
            if let cart = cart{
                for food in cart{
                    deleteItem(for: currentUser, id: Int(food.foodIDInCart)!){ error in
                        completion(error)
                    }
                }
            }
        }
    }

//    func queryFoodID(foodName: String ) -> Int{
//        // get food data
//        let allFoodsURLString = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
//        var foodId = 0
//        AF.request(allFoodsURLString,method: .get).response{ response in
//            if let data = response.data{
//                do{
//                    let decodedData = try JSONDecoder().decode(FoodResponse.self, from: data)
//                    let food = decodedData.foods.filter({$0.foodName == foodName}).first!
//                    foodId = Int(food.foodId)!
//                }catch{
//                    print(error)
//                }
//            }
//        }
//        return foodId
//    }
}
