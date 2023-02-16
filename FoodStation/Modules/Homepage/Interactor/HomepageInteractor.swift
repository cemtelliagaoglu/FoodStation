//
//  HomepageInteractor.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import FirebaseAuth

class HomepageInteractor: HomepagePresenterToInteractor{
    // food data
    // load user-cart data to calculate total price and return it to the view
    var foodList: [Food]?
    
    var presenter: HomepageInteractorToPresenter?
    
    func requestLoadFoodList(){
        APIService.requestAllFoodsInDatabase { foods, errorMessage in
            if errorMessage != nil{
                self.presenter?.requestFailed(with: errorMessage!)
            }else{
                self.foodList = foods
                self.presenter?.loadDataSucceed()
            }
        }
    }
    
    func requestUpdateCartForFood(at index: Int, amount: Int) {
        if let currentUser = Auth.auth().currentUser?.email{
            guard let food = foodList?[index] else{ return }
            APIService.requestAddToCart(for: currentUser, food: food, amount: amount) { response in
                if response == "success"{
                    self.presenter?.updatedSuccessfully()
                }
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
    func requestSignOut() {
        do{
            try Auth.auth().signOut()
            presenter?.requestSignOutSucceed()
        }catch{
            print(error)
            presenter?.requestFailed(with: error.localizedDescription)
        }
    }
}


