//
//  HomepageInteractor.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import FirebaseAuth
import FirebaseDatabase

class HomepageInteractor: HomepagePresenterToInteractor{
    // food data
    // load user-cart data to calculate total price and return it to the view
    var foodList: [Food]?
    
    var presenter: HomepageInteractorToPresenter?
    
    func requestLoadFoodList(){
        if let currentUID = Auth.auth().currentUser?.uid{
            // if user is logged in, requestAllFoods
            APIService.requestAllFoodsInDatabase { foods, errorMessage in
                if errorMessage != nil{
                    self.presenter?.requestFailed(with: errorMessage!)
                }else{
                    if foods != nil{
                        // Check database for liked foodIDs,
                        // if foodID matches with food in foodList, set matching food(s) didLike true
                        Database.database().reference().child("user-like").child(currentUID).observe(.value) { snapshot in
                            var tempList = [Food]()
                            for var food in foods!{
                                if snapshot.hasChild(food.foodId){
                                    food.didLike = true
                                }
                                tempList.append(food)
                            }
                            self.foodList = tempList
                            self.presenter?.loadDataSucceed()
                        }
                    }
                }
            }
        }
    }
    func requestFoodAmount(at index: Int) {
        if let currentUser = Auth.auth().currentUser?.email{
            APIService.requestUserCartInfo(for: currentUser) { foods in
                if let cart = foods{
                    guard let foodAtIndex = self.foodList?[index] else{
                        print("FoodList At \(index), is empty")
                        return
                    }
                    for foodInCart in cart{
                        if foodInCart.foodName == foodAtIndex.foodName{
                            let indexPath = IndexPath(row: index, section: 1)
                            self.presenter?.updatedSuccessfully(at: indexPath)
                        }
                    }
                }
            }
        }
    }
    
    func requestUpdateCartForFood(at index: Int, amount: Int) {
        if let currentUser = Auth.auth().currentUser?.email{
            guard let food = foodList?[index] else{ return }
            APIService.requestAddToCart(for: currentUser, food: food, amount: amount) { response in
                if response == "success"{
                    self.presenter?.updatedSuccessfully()
                }else{
                    self.presenter?.requestFailed(with: response)
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
    func updateFoodLike(at index: Int, didLike: Bool) {
        guard let foodID = foodList?[index].foodId else{ return }
        
        if let currentUID = Auth.auth().currentUser?.uid{
            FirebaseService.requestUpdateFoodLike(for: currentUID, foodID: foodID, didLike: didLike) { error in
                if error != nil{
                    self.presenter?.requestFailed(with: error!.localizedDescription)
                }else{
                    self.presenter?.updatedSuccessfully()
                }
            }
        }
    }
    
    
}


