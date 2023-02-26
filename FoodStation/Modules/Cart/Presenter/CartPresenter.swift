//
//  CartPresenter.swift
//  FoodStation
//
//  Created by admin on 8.02.2023.
//
import Foundation

class CartPresenter: CartViewToPresenter{
    
    var interactor: CartPresenterToInteractor?
    var router: CartPresenterToRouter?
    var view: CartPresenterToView?
    
    func notifyViewDidLoad() {
        view?.configUI()
        interactor?.requestLoadCart()
    }
    func foodForCell(at index: Int) -> FoodInCart? {
        return interactor?.foodInCart(at: index)
    }
    
    func numberOfItems() -> Int? {
        return interactor?.numberOfFoodsInCart()
    }
    func shouldUpdatePriceLabel() {
        interactor?.calculatePriceInCart()
    }
    
    func amountDidChange(at indexPath: IndexPath, newAmount: Int) {
        if newAmount == 0{
            interactor?.deleteItem(at: indexPath)
        }else{
            interactor?.requestUpdateCart(at: indexPath, newAmount: newAmount)
            view?.startLoadingAnimation(at: indexPath)
        }
    }
    func deleteAllCartTapped() {
        interactor?.requestDeleteAllCart()
    }
}
//MARK: - InteractorPresenter Methods
extension CartPresenter: CartInteractorToPresenter{
    
    func updatedCart() {
        view?.reloadData()
    }
    
    func updatedCart(at indexPath: IndexPath) {
        view?.stopLoadingAnimation(at: indexPath)
        view?.reloadData()
    }
    
    func requestFailed(with errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
    func calculatedTotalPrice(_ price: Int) {
        view?.setPriceLabel(with: "\(price) TL")
    }
    func deletedAllCartSuccessfully() {
        router?.popVC()
        view?.reloadData()
    }
}
