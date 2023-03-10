//
//  CartProtocols.swift
//  FoodStation
//
//  Created by admin on 8.02.2023.
//

import UIKit

protocol CartViewToPresenter{
    var interactor: CartPresenterToInteractor? { get set }
    var router: CartPresenterToRouter? { get set }
    
    func notifyViewDidLoad()
    func notifyViewWillAppear()
    func amountDidChange(at indexPath: IndexPath, newAmount: Int)
    func foodForCell(at index: Int) -> FoodInCart?
    func numberOfItems() -> Int?
    func shouldUpdatePriceLabel()
    func deleteAllCartTapped()
    func checkoutTapped()
}
protocol CartPresenterToInteractor{
    var presenter: CartInteractorToPresenter? { get set }
    
    func requestLoadCart()
    func calculatePriceInCart()
    func requestUpdateCart(at indexPath: IndexPath, newAmount: Int)
    func deleteItem(at indexPath: IndexPath)
    func foodInCart(at index: Int) -> FoodInCart?
    func numberOfFoodsInCart() -> Int?
    func requestDeleteAllCart()
}
protocol CartInteractorToPresenter{
    var view: CartPresenterToView? { get set }
    
    func updatedCart()
    func updatedCart(at indexPath: IndexPath)
    func requestFailed(with errorMessage: String)
    func calculatedTotalPrice(_ price: Int)
    func deletedAllCartSuccessfully()
}
protocol CartPresenterToView{
    
    func configUI()
    func showErrorMessage(_ errorMessage: String)
    func reloadData()
    func startLoadingAnimation(at indexPath: IndexPath)
    func stopLoadingAnimation(at indexPath: IndexPath)
    func setPriceLabel(with price: String)
}
protocol CartPresenterToRouter{
    static func createModule() -> UINavigationController
    func pushToHomepage()
    func pushToCheckout()
}
