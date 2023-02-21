//
//  HomepageProtocols.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit

protocol HomepageViewToPresenter{
    var interactor: HomepagePresenterToInteractor? { get set }
    var view: HomepagePresenterToView? { get set }
    var router: HomepagePresenterToRouter? { get set }
    
    func notifyViewDidLoad()
    func updateFoodInCart(at indexPath: IndexPath, amount: Int)
    func numberOfItems() -> Int?
    func foodForCell(at index: Int) -> Food?
    func logOutTapped()
    func didSelectFood(at index: Int)
    func didLikeFood(at index: Int, didLike: Bool)
    func foodAmountForCell(at index: Int) -> Int
}

protocol HomepagePresenterToInteractor{
    var presenter: HomepageInteractorToPresenter? { get set }
    
    func requestLoadFoodList()
    func requestUpdateCartForFood(at index: Int, amount: Int)
    func numberOfFoods() -> Int?
    func foodForCell(at index: Int) -> Food?
    func requestSignOut()
    func foodInfo(at index: Int) -> Food?
    func updateFoodLike(at index: Int, didLike: Bool)
    func requestFoodAmount(at index: Int)
}

protocol HomepageInteractorToPresenter{
    
    func loadDataSucceed()
    func requestFailed(with errorMessage: String)
    func updatedSuccessfully()
    func updatedSuccessfully(at indexPath: IndexPath)
    func requestSignOutSucceed()
}

protocol HomepagePresenterToView{
    
    func configUI()
    func showErrorMessage(_ errorMessage: String)
    func reloadData()
    func startLoadingAnimation(at indexPath: IndexPath)
    func stopLoadingAnimation(at indexPath: IndexPath)
}


protocol HomepagePresenterToRouter{
    static func createModule() -> UINavigationController
    
    func pushToLoginVC()
    func pushToDetailsVC(for food: Food)
}
