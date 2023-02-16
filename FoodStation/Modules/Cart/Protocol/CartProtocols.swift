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
    func amountDidChange(at indexPath: IndexPath, newAmount: Int)
    func foodForCell(at index: Int) -> FoodInCart?
    func numberOfItems() -> Int?
    
}
protocol CartPresenterToInteractor{
    var presenter: CartInteractorToPresenter? { get set }
    
    func requestLoadCart()
    func requestUpdateCart(at indexPath: IndexPath, newAmount: Int)
    func foodInCart(at index: Int) -> FoodInCart?
    func numberOfFoodsInCart() -> Int?
}
protocol CartInteractorToPresenter{
    var view: CartPresenterToView? { get set }
    
    func updatedCart(at indexPath: IndexPath?)
    func requestFailed(with errorMessage: String)
    func calculatedTotalPrice(_ price: Int)
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
}
