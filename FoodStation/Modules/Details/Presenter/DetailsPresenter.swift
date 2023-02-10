//
//  DetailsPresenter.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import Foundation

class DetailsPresenter: DetailsViewToPresenter{
    
    var interactor: DetailsPresenterToInteractor?
    var router: DetailsPresenterToRouter?
    var view: DetailsPresenterToView?
    
    func notifyViewDidLoad() {
        // interactor.loadCartInfo
        view?.configUI()
    }
    func foodDidSet(_ food: Food) {
        interactor!.requestFoodAmountInCart(for: food)  
    }
    func addToCartTapped(for food: Food, amount: Int) {
        interactor?.requestAddToCart(food: food, amount: amount)
    }
    
    
}
//MARK: - InteractorToPresenter Methods
extension DetailsPresenter: DetailsInteractorToPresenter{
    
    func requestFoodAmountSucceed(_ amount: Int) {
        view?.setFoodAmount(amount)
    }
    func fetchedSuccessfully(_ food: Food) {
        
    }
    func fetchingFailure(with error: Error) {
        
    }
    
    func addedCartSuccessfuly() {
        router?.popVC()
    }
    func failedToAdd(withErrorMessage message: String) {
        view?.showError(message)
    }
}
