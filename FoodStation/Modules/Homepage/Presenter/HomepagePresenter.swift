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
    func notifyViewWillAppear() {
        view?.reloadData()
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
    func updateFoodInCart(at indexPath: IndexPath, amount: Int) {
        interactor?.requestUpdateCartForFood(at: indexPath, amount: amount)
        view?.startLoadingAnimation(at: indexPath)
    }
    func didLikeFood(at indexPath: IndexPath, didLike: Bool) {
        interactor?.updateFoodLike(at: indexPath, didLike: didLike)
    }
    func foodAmountForCell(at indexPath: IndexPath) {
        interactor?.requestFoodAmount(at: indexPath)
    }
    func profileButtonTapped() {
        router?.pushToProfileVC()
    }
}
//MARK: - InteractorToPresenter Methods
extension HomepagePresenter: HomepageInteractorToPresenter{
    
    func loadedFoodListSuccessfully() {
        view?.reloadData()
    }
    func checkedCartSuccessfully(at indexPath: IndexPath, amountInCart: Int) {
        view?.updateFoodAmountForCell(at: indexPath, amount: amountInCart)
    }
    func updatedSuccessfully(at indexPath: IndexPath) {
        view?.stopLoadingAnimation(at: indexPath)
    }
    func requestFailed(with errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
    
}
