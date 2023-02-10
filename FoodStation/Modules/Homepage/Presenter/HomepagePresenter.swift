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
    
    func logOutTapped() {
        interactor?.requestSignOut()
    }
    
    func didSelectFood(_ food: Food) {
        router?.pushToDetailsVC(for: food)
    }
    
}

extension HomepagePresenter: HomepageInteractorToPresenter{
    
    func loadDataSucceed(with foods: [Food]) {
        view?.sendFetchedData(foods)
    }
    func loadDataFailed() {
        
    }
    func requestSignOutFailed() {
        view?.failedToSignOut()
    }
    func requestSignOutSucceed() {
        router?.pushToLoginVC()
    }
    func goToLoginVC(from navController: UINavigationController) {
//        router?.goToLoginVC(from: navController)
    }
    func goToDetailsVC(from navController: UINavigationController, food: Food?) {
//        router?.goToDetailsVC(from: navController, food: food)
    }
    
}
