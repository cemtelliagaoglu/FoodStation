//
//  DetailsInteractor.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//
import Foundation

class DetailsInteractor: DetailsPresenterToInteractor{
    
    var presenter: DetailsInteractorToPresenter?
    
    func requestFoodAmountInCart(for food: Food){
        DispatchQueue.main.async{
            APIService.requestUserCartInfo { foods in
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
    func requestUpdateCart(food: Food, amount: Int) {
        
        APIService.requestAddToCart(food: food, amount: amount) { response in
            if response == "success"{
                self.presenter?.updatedCartSuccessfuly()
            }else{
                self.presenter?.requestFailed(withErrorMessage: response)
            }
        }
    }
    func requestUpdateFoodLike(_ food: Food, didLike: Bool) {
        
        FirebaseService.requestUpdateFoodLike(foodID: food.foodId, didLike: didLike) { error in
            if error != nil{
                self.presenter?.requestFailed(withErrorMessage: error!.localizedDescription)
            }else{
                self.presenter?.updatedFoodLikeSuccessfully(didLike: didLike)
            }
        }
    }
}
