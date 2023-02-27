//
//  CheckoutPresenter.swift
//  FoodStation
//
//  Created by admin on 24.02.2023.
//

import Foundation

class CheckoutPresenter: CheckoutViewToPresenter{
    var interactor: CheckoutPresenterToInteractor?
    var view: CheckoutPresenterToView?
    var router: CheckoutPresenterToRouter?
    
    func notifyViewDidLoad() {
        view?.configUI()
    }
    func notifyViewWillAppear() {
        interactor?.requestLoadCart()
        interactor?.requestLoadUserInfo()
    }
    func orderButtonPressed() {
        interactor?.createOrder()
    }
    func changeAddressTapped(newAddress: String) {
        interactor?.requestUpdateAddress(newAddress: newAddress)
    }
    func changeCreditCardTapped(newCardNumber: String) {
        interactor?.requestUpdateCreditCard(newCardNumber: newCardNumber)
    }
    func numberOfItems() -> Int? {
        return interactor?.numberOfFoodsInCart()
    }
    func foodForCell(at index: Int) -> FoodInCart? {
        return interactor?.foodInfo(at: index)
    }
    
}
//MARK: - InteractorToPresenter
extension CheckoutPresenter: CheckoutInteractorToPresetner{
    func createdOrderSuccessfully() {
        router?.showResultVC()
    }
    func loadedUserInfoSuccessfully(address: String, cardNumber: String) {
        view?.setUserInfo(address: address, cardNumber: cardNumber)
    }
    func loadedCartSuccessfully() {
        view?.reloadData()
    }
    func calculatedTotalPrice(_ price: Int) {
        view?.setPriceLabel("\(price) TL")
    }
    func requestFailed(with errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
}
