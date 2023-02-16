//
//  DetailsPresenter.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

class DetailsPresenter: DetailsViewToPresenter{
    
    var interactor: DetailsPresenterToInteractor?
    var router: DetailsPresenterToRouter?
    var view: DetailsPresenterToView?
    
    func notifyViewDidLoad() {
        view?.configUI()
    }
    func notifyViewWillAppear(for food: Food) {
        interactor?.requestFoodAmountInCart(for: food)
    }
    func foodDidSet(_ food: Food) {
        // request food amount in cart, if doesn't exist return 0
        interactor?.requestFoodAmountInCart(for: food)
    }
    
    func foodAmountDidChange(for food: Food, amount: Int) {
        if amount > 0{
            interactor?.requestUpdateCart(food: food, amount: amount)
            view?.startLoadingAnimation()
        }else{
            interactor?.requestUpdateCart(food: food, amount: amount)
        }
    }
    
}
//MARK: - InteractorToPresenter Methods
extension DetailsPresenter: DetailsInteractorToPresenter{
    
    func foodAmountInCart(_ amount: Int) {
        view?.setFoodAmount(amount)
        view?.stopLoadingAnimation()
    }
    func updatedCartSuccessfuly() {
        view?.stopLoadingAnimation()
    }
    
    func requestFailed(withErrorMessage message: String) {
        view?.showError(message)
    }
}
