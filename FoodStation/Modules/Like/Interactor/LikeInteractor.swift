//
//  LikeInteractor.swift
//  FoodStation
//
//  Created by admin on 21.02.2023.
//

class LikeInteractor: LikePresenterToInteractor{
    
    var foodList: [Food]?
    
    var presenter: LikeInteractorToPresenter?
    
    func requestLoadingLikedFoods() {
        
        FirebaseService.requestLoadLikedFoodList{ foods in
            if let likedFoods = foods{
                self.foodList = likedFoods
                self.presenter?.loadedLikedFoodsSuccessfully()
            }else{
                self.presenter?.requestFailed(with: "You don't have liked foods")
            }
        }
    }
    func numberOfFoods() -> Int? {
        return foodList?.count
    }
    func foodInfo(at index: Int) -> Food? {
        return foodList?[index]
    }
    func removeLikedFood(at index: Int) {
        
        guard let foodID = foodList?[index].foodId else{ return }
        FirebaseService.requestUpdateFoodLike(foodID: foodID, didLike: false) { error in
            if error != nil{
                self.presenter?.requestFailed(with: error!.localizedDescription)
            }else{
                self.presenter?.removedLikeSuccessfully()
            }
        }
    }
    
}
