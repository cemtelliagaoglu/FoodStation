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
    func updateFoodInCart(at indexPath: IndexPath, amount: Int) {
        interactor?.requestUpdateCartForFood(at: indexPath.row, amount: amount)
        view?.startLoadingAnimation(at: indexPath)
    }
    func logOutTapped() {
        interactor?.requestSignOut()
    }
    func didLikeFood(at index: Int, didLike: Bool) {
        interactor?.updateFoodLike(at: index, didLike: didLike)
    }
    func foodAmountForCell(at index: Int) -> Int {
        return 1
    }
}
//MARK: - InteractorToPresenter Methods
extension HomepagePresenter: HomepageInteractorToPresenter{
    
    func loadDataSucceed() {
        view?.reloadData()
    }
    func updatedSuccessfully() {
        view?.reloadData()
    }
    func updatedSuccessfully(at indexPath: IndexPath) {
        view?.stopLoadingAnimation(at: indexPath)
    }
    func requestFailed(with errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
    func requestSignOutSucceed() {
        router?.pushToLoginVC()
    }
    
}
