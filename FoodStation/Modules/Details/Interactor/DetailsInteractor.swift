//
//  DetailsInteractor.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import Foundation
import FirebaseAuth
import Alamofire

class DetailsInteractor: DetailsPresenterToInteractor{
    
    private let foodsInCartBaseURL = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
    private let addToCartBaseURL = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
    private let deleteFoodBaseURL = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
    
    var presenter: DetailsInteractorToPresenter?
    
    func requestFoodAmountInCart(for food: Food) {
        
        DispatchQueue.main.async {
            self.requestUserCartInfo { foods in
                for foodInCart in foods{
                    if foodInCart.foodName == food.foodName{
                        self.presenter?.requestFoodAmountSucceed(Int(foodInCart.foodAmount)!)
                    }
                }
            }
        }
    }
    
    func requestUserCartInfo(completion: @escaping(([FoodInCart]) -> ())) {
        // load user's cart and return amount for selected food
        if let currentUser = Auth.auth().currentUser?.email{
            // load Cart
            let params = ["kullanici_adi": currentUser]
            AF.request(URL(string: foodsInCartBaseURL)!,method: .post, parameters: params).response(){ response in
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(CartResponse.self, from: data)
                        completion(response.cart!)
                        print("Success: \(response.success)")
                        print("Sepet ID: \(response.cart![0].foodIDInCart) - Kullanici Adi: \(response.cart![0].username)")
                        
                    }catch{
                        print(error)
                    }
                }
            }
        }
    }
    
    func requestAddToCart(food: Food, amount: Int) {
        // load current cart info and find selected food
        // remove current amount from cart, then  create a new object in cart
        // required params to load: username
        // params for deleting: cartId (Int), username (String)
        // params to create: foodName(String), foodImageName(String), FoodPrice(Int), FoodAmount(Int),username(String)
        deleteFoodIfInCart(food)
        if amount > 0{
            // create new cart with updated amount of food
            if let currentUser = Auth.auth().currentUser?.email{
                let params: [String: Any] = ["yemek_adi":food.foodName,"yemek_resim_adi":food.foodImageName, "yemek_fiyat": Int(food.foodPrice)!,"yemek_siparis_adet": amount,"kullanici_adi": currentUser]
                
                AF.request(URL(string: addToCartBaseURL)!,method: .post, parameters: params).response(){ response in
                    if let data = response.data{
                        do{
                            let response = try JSONDecoder().decode(CartResponse.self, from: data)
                            if response.success == 1{
                                self.presenter?.addedCartSuccessfuly()
                            }else{
                                self.presenter?.failedToAdd(withErrorMessage: response.message!)
                            }
                            print("Adding to Cart Status: \(response.success == 1 ? "Successfull" : "Failed")")
                            
                        }catch{
                            print(error)
                        }
                    }
                }
            }
        }
        
    }
    
    func deleteFoodIfInCart(_ food: Food){
        // if user has selected food in the cart, delete from cart
        requestUserCartInfo { foods in
            
            for foodInDatabase in foods{
                if foodInDatabase.foodName == food.foodName{
                    self.deleteItem(id: Int(foodInDatabase.foodIDInCart)!)
                }
            }
        }
    }
    
    func deleteItem(id: Int){
        if let currentUser = Auth.auth().currentUser?.email{
            // sepeti sil
            let params: [String:Any] = ["kullanici_adi": currentUser, "sepet_yemek_id": id]
            AF.request(URL(string: deleteFoodBaseURL)!,method: .post, parameters: params).response(){ response in
                if let data = response.data{
                    do{
                        let response = try JSONDecoder().decode(CartResponse.self, from: data)
                        print("Deleting CartID: \(id)...")
                        print("Success: \(response.success == 1 ? "Success": "Failed")")
                        
                    }catch{
                        print(error)
                    }
                }
            }
            
        }
    }
    
    func addToCart(for username: String,_ food: Food, amount: Int){
        
        print("FoodName: \(food.foodName) - FoodImageName: \(food.foodImageName) - FoodPrice: \(food.foodPrice)")
        let foodPrice = Int(food.foodPrice)!
        
        let params: [String: Any] = ["yemek_adi":food.foodName,"yemek_resim_adi":food.foodImageName, "yemek_fiyat": foodPrice,"yemek_siparis_adet": amount,"kullanici_adi": username]
        
        AF.request(URL(string: addToCartBaseURL)!,method: .post, parameters: params).response(){ response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(CartResponse.self, from: data)
                    print("Adding to Cart Status: \(response.success == 1 ? "Successfull" : "Failed")")
                    
                }catch{
                    print(error)
                }
            }
        }
    }
    
}
