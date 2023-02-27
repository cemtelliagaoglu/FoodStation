//
//  CheckoutInteractor.swift
//  FoodStation
//
//  Created by admin on 24.02.2023.
//

import Foundation

class CheckoutInteractor: CheckoutPresenterToInteractor{
    // Address: 0
    var cart: [FoodInCart]?
    var userInfo: [String: String]?
    var totalPrice = 0
    
    var presenter: CheckoutInteractorToPresetner?
    
    func foodInfo(at index: Int) -> FoodInCart? {
        return cart?[index]
    }
    
    func numberOfFoodsInCart() -> Int? {
        return cart?.count
    }
    func requestLoadCart() {
        APIService.requestUserCartInfo { cart in
            self.cart = cart
            self.calculatePriceInCart()
            self.presenter?.loadedCartSuccessfully()
        }
    }
    func requestLoadUserInfo() {
        FirebaseService.requestLoadUserInfo { userInfo in
            guard let address = userInfo["address"] as? String else{ return }
            guard let cardNumber = userInfo["card_number"] as? String else{ return }
            self.userInfo = userInfo as? [String: String]
            self.presenter?.loadedUserInfoSuccessfully(address: address, cardNumber: cardNumber)
        }
    }
    
    func calculatePriceInCart(){
        var totalPrice = 0
        if let cart = self.cart{
            for food in cart{
                totalPrice += Int(food.foodPrice)! * Int(food.foodAmount)!
            }
        }
        self.totalPrice = totalPrice
        presenter?.calculatedTotalPrice(totalPrice)
    }
    
    func requestUpdateAddress(newAddress: String) {
        // since the loadUserInfo func works real time, there's no need to tell presenter that it's updated
        FirebaseService.requestUpdateUserAddress(newAddress: newAddress)
    }
    func requestUpdateCreditCard(newCardNumber: String) {
        FirebaseService.requestUpdateUserCreditCard(newCardNumber: newCardNumber)
    }
    
    func createOrder() {
        if let cart = cart{
            // order-history -> uid -> order-id -> address: "" , details: [FoodName,FoodAmount, FoodPrice, FoodImageURL],
            guard let address = self.userInfo?["address"] else{ return }
            guard let cardNumber = self.userInfo?["card_number"] else{ return }
            let date = String(Date().timeIntervalSince1970)
            
            FirebaseService.requestSaveOrder(cart: cart, price: self.totalPrice, address: address, cardNumber: cardNumber, date: date) { error in
                if error != nil{
                    self.presenter?.requestFailed(with: error!.localizedDescription)
                }else{
                    self.cart = nil
                    self.presenter?.createdOrderSuccessfully()
                    APIService.deleteAllCart()
                }
            }
        }
    }
}
