//
//  LikePresenter.swift
//  FoodStation
//
//  Created by admin on 21.02.2023.
//

class LikePresenter: LikeViewToPresenter{
    var interactor: LikePresenterToInteractor?
    
    var router: LikePresenterToRouter?
    
    var view: LikePresenterToView?
    
    func notifyViewDidLoad() {
        view?.configUI()
        interactor?.requestLoadingLikedFoods()
    }
    func foodForCell(at index: Int) -> Food? {
        return interactor?.foodInfo(at: index)
    }
    
    func numberOfItems() -> Int? {
        return interactor?.numberOfFoods()
    }
    
    func didSelectFood(at index: Int) {
        guard let food = interactor?.foodInfo(at: index) else{ return }
        router?.pushToDetails(for: food)
    }
    func likeButtonTapped(at index: Int) {
        interactor?.removeLikedFood(at: index)
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
    func removedLikeSuccessfully() {
        view?.reloadData()
    }
}
