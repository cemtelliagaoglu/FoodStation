//
//  HomepagePresenter.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit

class HomepagePresenter: HomepageViewToPresenter{
    
    var interactor: HomepagePresenterToInteractor?
    var view: HomepagePresenterToView?
    var router: HomepagePresenterToRouter?
    
    func loadData() {
        interactor?.loadData()
    }
    
    func changeVC() {
        
        router?.changeVC()
    }
    
}

extension HomepagePresenter: HomepageInteractorToPresenter{
    
    func sendFetchedData(_ foods: [Food]) {
        view?.sendFetchedData(foods)
    }
}
