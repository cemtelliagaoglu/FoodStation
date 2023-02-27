//
//  CheckoutProtocols.swift
//  FoodStation
//
//  Created by admin on 24.02.2023.
//

import UIKit

protocol CheckoutViewToPresenter{
    var interactor: CheckoutPresenterToInteractor? { get set }
    var router: CheckoutPresenterToRouter? { get set }
    var view: CheckoutPresenterToView? { get set }
    
    func notifyViewDidLoad()
    func notifyViewWillAppear()
    func changeAddressTapped(newAddress: String)
    func changeCreditCardTapped(newCardNumber: String)
    func foodForCell(at index: Int) -> FoodInCart?
    func numberOfItems() -> Int?
    func orderButtonPressed()
}
protocol CheckoutPresenterToInteractor{
    var presenter: CheckoutInteractorToPresetner? { get set }
    
    func requestLoadCart()
    func requestLoadUserInfo()
    func foodInfo(at index: Int) -> FoodInCart?
    func numberOfFoodsInCart() -> Int?
    func requestUpdateAddress(newAddress: String)
    func requestUpdateCreditCard(newCardNumber: String)
    func createOrder()
}
protocol CheckoutInteractorToPresetner{
    func createdOrderSuccessfully()
    func loadedUserInfoSuccessfully(address: String, cardNumber: String)
    func loadedCartSuccessfully()
    func calculatedTotalPrice(_ price: Int)
    func requestFailed(with errorMessage: String)
}

protocol CheckoutPresenterToView{
    func configUI()
    func reloadData()
    func setUserInfo(address: String, cardNumber: String)
    func setPriceLabel(_ price: String)
    func showErrorMessage(_ errorMessage: String)
}

protocol CheckoutPresenterToRouter{
    static func createModule() -> CheckoutVC
    func showResultVC()
}
