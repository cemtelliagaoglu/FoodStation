//
//  HomepageInteractor.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import Foundation

class HomepageInteractor: HomepagePresenterToInteractor{
    
    var foodList: [Food]?
    
    var presenter: HomepageInteractorToPresenter?
    
    func requestLoadFoodList(){
        APIService.requestAllFoodsInDatabase { foods, errorMessage in
            if errorMessage != nil{
                self.presenter?.requestFailed(with: errorMessage!)
            }else{
                if foods != nil{
                    // Check database for liked foodIDs,
                    // if foodID matches with food in foodList, set matching food(s) didLike true
                    FirebaseService.addLikesToFoodList(for: foods!) { updatedList in
                        self.foodList = updatedList
                        self.presenter?.loadedFoodListSuccessfully()
                    }
                }
            }
        }
    }
    
    func requestFoodAmount(at indexPath: IndexPath) {

        APIService.requestUserCartInfo{ foods in
            if let cart = foods{
                guard let foodAtIndex = self.foodList?[indexPath.row] else{
                    print("FoodList at \(indexPath.row), is empty")
                    return
                }
                for foodInCart in cart{
                    if foodInCart.foodName == foodAtIndex.foodName{
                        self.presenter?.checkedCartSuccessfully(at: indexPath, amountInCart: Int(foodInCart.foodAmount)!)
                        return
                    }
                }
            }
            self.presenter?.checkedCartSuccessfully(at: indexPath, amountInCart: 0)
        }
    }
    
    func requestUpdateCartForFood(at indexPath: IndexPath, amount: Int) {
        
        guard let food = foodList?[indexPath.row] else{ return }
        APIService.requestAddToCart(food: food, amount: amount) { response in
            if response == "success"{
                self.presenter?.updatedSuccessfully(at: indexPath)
            }else{
                self.presenter?.requestFailed(with: response)
            }
        }
    }
    
    func numberOfFoods() -> Int? {
        return foodList?.count
    }
    func foodForCell(at index: Int) -> Food? {
        return foodList?[index]
    }
    func foodInfo(at index: Int) -> Food? {
        return foodList?[index]
    }
    
    func updateFoodLike(at indexPath: IndexPath, didLike: Bool) {
        
        guard let foodID = foodList?[indexPath.row].foodId else{ return }
        FirebaseService.requestUpdateFoodLike(foodID: foodID, didLike: didLike) { error in
            if error != nil{
                self.presenter?.requestFailed(with: error!.localizedDescription)
            }else{
                self.presenter?.updatedSuccessfully(at: indexPath)
            }
        }
    }
    
}


