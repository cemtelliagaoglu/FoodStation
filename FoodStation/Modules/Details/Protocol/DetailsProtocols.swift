//
//  DetailsProtocols.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit

protocol DetailsViewToPresenter{
    var interactor: DetailsPresenterToInteractor? { get set }
    var router: DetailsPresenterToRouter? { get set }
    
    func notifyViewDidLoad()
    func addToCartTapped(for food: Food, amount: Int)
    func foodDidSet(_ food: Food)
//    func loadCardInfo()
}

protocol DetailsPresenterToInteractor{
    var presenter: DetailsInteractorToPresenter? { get set }
    
    func requestAddToCart(food: Food, amount: Int)
    func requestFoodAmountInCart(for food: Food)
    
}

protocol DetailsInteractorToPresenter{
    var view: DetailsPresenterToView? { get set }
    
    func fetchedSuccessfully(_ food: Food)
    func fetchingFailure(with error: Error)
    
    func addedCartSuccessfuly()
    func failedToAdd(withErrorMessage message: String)
    
    func requestFoodAmountSucceed(_ amount: Int)
//    func deleteFromCard(_ foodId: Int)
}

protocol DetailsPresenterToView{
    
    func updateView(with food: Food)
    func configUI()
    func setFoodAmount(_ amount: Int)
    func showError(_ message: String)
//    func sendFetchedData(_ foods: Food, image: UIImage)
}


protocol DetailsPresenterToRouter{
    static func createModule() -> DetailsVC
    
    func popVC()
}
