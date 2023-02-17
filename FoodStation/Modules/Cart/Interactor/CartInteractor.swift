//
//  CartInteractor.swift
//  FoodStation
//
//  Created by admin on 8.02.2023.
//

import FirebaseAuth

class CartInteractor: CartPresenterToInteractor{
    
    var presenter: CartInteractorToPresenter?
    
    var cart: [FoodInCart]?
    
    func foodInCart(at index: Int) -> FoodInCart? {
        return cart?[index]
    }
    
    func numberOfFoodsInCart() -> Int? {
        return cart?.count
    }
 
    
    func requestLoadCart() {
        if let currentUser = Auth.auth().currentUser?.email{
            APIService.requestUserCartInfo(for: currentUser) { cart in
                self.cart = cart
                self.calculatePriceInCart()
                self.presenter?.updatedCart()
            }
        }
    }
    
    func requestUpdateCart(at indexPath: IndexPath, newAmount: Int) {
        if let currentUser = Auth.auth().currentUser?.email{
            guard let food = cart?[indexPath.row] else{ return }
            if newAmount == 0{
                APIService.deleteItem(foodIDInCart: Int(food.foodIDInCart)!, for: currentUser)
                self.cart?.remove(at: indexPath.row)
                self.presenter?.updatedCart(at: indexPath)
            }else{
                APIService.requestAddToCart(for: currentUser, foodInCart: food, amount: newAmount) { result in
                    if result == "success"{
                        self.requestLoadCart()
                        self.presenter?.updatedCart(at: indexPath)
                    }else{
                        self.presenter?.requestFailed(with: result)
                    }
                }
            }
        }
    }
    
    func calculatePriceInCart(){
        var totalPrice = 0
        if let cart = self.cart{
            for food in cart{
                totalPrice += Int(food.foodPrice)! * Int(food.foodAmount)!
            }
        }
        presenter?.calculatedTotalPrice(totalPrice)
    }
    
    func requestDeleteAllCart() {
        if let currentUser = Auth.auth().currentUser?.email{
            DispatchQueue.main.async {
                APIService.deleteAllCart(for: currentUser) { error in
                    if error != nil{
                        self.presenter?.requestFailed(with: error!.localizedDescription)
                    }else{
                        self.cart = nil
                        self.presenter?.deletedAllCartSuccessfully()
                    }
                }
            }
        }
    }
    
}
