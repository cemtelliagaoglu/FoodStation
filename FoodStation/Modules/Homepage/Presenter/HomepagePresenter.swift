//
//  HomepagePresenter.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import Foundation

class HomepagePresenter: HomepageViewToPresenter{

    var interactor: HomepagePresenterToInteractor?
    var view: HomepagePresenterToView?
    var router: HomepagePresenterToRouter?
    
    func notifyViewDidLoad() {
        view?.configUI()
        interactor?.requestLoadFoodList()
    }
    func numberOfItems() -> Int? {
        return interactor?.numberOfFoods()
    }
    func foodForCell(at index: Int) -> Food? {
        return interactor?.foodForCell(at: index)
    }
    func didSelectFood(at index: Int) {
        guard let food = interactor?.foodInfo(at: index)else{ return }
        router?.pushToDetailsVC(for: food)
    }
    func updateFoodInCart(at index: Int, amount: Int) {
        interactor?.requestUpdateCartForFood(at: index, amount: amount)
        view?.startLoadingAnimation()
    }
    func logOutTapped() {
        interactor?.requestSignOut()
    }
   
}
//MARK: - InteractorToPresenter Methods
extension HomepagePresenter: HomepageInteractorToPresenter{
    
    func loadDataSucceed() {
        view?.reloadData()
    }
    func updatedSuccessfully() {
        view?.reloadData()
        view?.stopLoadingAnimation()
    }
    func requestFailed(with errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
    func requestSignOutSucceed() {
        router?.pushToLoginVC()
    }
    
}
