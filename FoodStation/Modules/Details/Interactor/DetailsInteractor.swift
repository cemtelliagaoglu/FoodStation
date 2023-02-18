//
//  DetailsInteractor.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import FirebaseAuth

class DetailsInteractor: DetailsPresenterToInteractor{
    
    var presenter: DetailsInteractorToPresenter?
    
    func requestFoodAmountInCart(for food: Food){
        if let currentUser = Auth.auth().currentUser?.email {
            DispatchQueue.main.async{
                APIService.requestUserCartInfo(for: currentUser) { foods in
                    if let cart = foods{
                        for foodInCart in cart{
                            if foodInCart.foodName == food.foodName{
                                self.presenter?.foodAmountInCart(Int(foodInCart.foodAmount)!)
                                return
                            }
                        }
                        // if food is not in cart
                        self.presenter?.foodAmountInCart(0)
                    }else{
                        // if cart is empty
                        self.presenter?.foodAmountInCart(0)
                    }
                }
            }
        }
    }
    func requestUpdateCart(food: Food, amount: Int) {
        if let currentUser = Auth.auth().currentUser?.email{
            APIService.requestAddToCart(for: currentUser, food: food, amount: amount) { response in
                if response == "success"{
                    self.presenter?.updatedCartSuccessfuly()
                }else{
                    self.presenter?.requestFailed(withErrorMessage: response)
                }
            }
        }
    }
}
