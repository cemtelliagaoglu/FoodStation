//
//  LikePresenter.swift
//  FoodStation
//
//  Created by admin on 21.02.2023.
//

import Foundation

class LikePresenter: LikeViewToPresenter{
    var interactor: LikePresenterToInteractor?
    
    var router: LikePresenterToRouter?
    
    var view: LikePresenterToView?
    
    func notifyViewDidLoad() {
        view?.configUI()
        interactor?.requestLoadingLikedFoods()
    }
    
    func numberOfItems() -> Int? {
        return interactor?.numberOfFoods()
    }
    
    func didSelectFood(at index: Int) {
        
    }
    
}
//MARK: - InteractorToPresenter
extension LikePresenter: LikeInteractorToPresenter{
    
    func loadedLikedFoodsSuccessfully() {
        view?.reloadData()
    }
    func requestFailed(with errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
}
