//
//  LikeInteractor.swift
//  FoodStation
//
//  Created by admin on 21.02.2023.
//


class LikeInteractor: LikePresenterToInteractor{
    var presenter: LikeInteractorToPresenter?
    
    func requestLoadingLikedFoods() {
        
    }
    func numberOfFoods() -> Int? {
        return 1
    }
    
}
