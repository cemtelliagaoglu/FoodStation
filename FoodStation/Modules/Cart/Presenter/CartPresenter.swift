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
    
    func amountDidChange(at indexPath: IndexPath, newAmount: Int) {
        interactor?.requestUpdateCart(at: indexPath, newAmount: newAmount)
        view?.startLoadingAnimation(at: indexPath)
    }
}
//MARK: - InteractorPresenter Methods
extension CartPresenter: CartInteractorToPresenter{
    
    func updatedCart(at indexPath: IndexPath?) {
        if let indexPath = indexPath{
            view?.stopLoadingAnimation(at: indexPath)
            view?.reloadData()
        }else{
            view?.reloadData()
        }
    }
    
    func requestFailed(with errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
    func calculatedTotalPrice(_ price: Int) {
        view?.setPriceLabel(with: "\(price) TL")
    }
}
