//
//  CheckoutPresenter.swift
//  FoodStation
//
//  Created by admin on 24.02.2023.
//

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
        view?.hideTabBar(isHidden: true)
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
    func backButtonTapped() {
        router?.popVC()
        view?.hideTabBar(isHidden: false)
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
        view?.setPriceLabel("Total: \(price) TL")
    }
    func requestFailed(with errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
}
