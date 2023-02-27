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
    func notifyViewWillAppear()
    func updateFoodInCart(at indexPath: IndexPath, amount: Int)
    func numberOfItems() -> Int?
    func foodForCell(at index: Int) -> Food?
    func profileButtonTapped()
    func didSelectFood(at index: Int)
    func didLikeFood(at indexPath: IndexPath, didLike: Bool)
    func foodAmountForCell(at indexPath: IndexPath)
    func searchTextDidChange(searchText: String)
}

protocol HomepagePresenterToInteractor{
    var presenter: HomepageInteractorToPresenter? { get set }
    
    func requestLoadFoodList()
    func requestUpdateCartForFood(at indexPath: IndexPath, amount: Int)
    func numberOfFoods() -> Int?
    func foodForCell(at index: Int) -> Food?
    func foodInfo(at index: Int) -> Food?
    func updateFoodLike(at indexPath: IndexPath, didLike: Bool)
    func requestFoodAmount(at indexPath: IndexPath)
    func filterFoodsContainingText(text: String)
}

protocol HomepageInteractorToPresenter{
    
    func loadedFoodListSuccessfully()
    func checkedCartSuccessfully(at indexPath: IndexPath, amountInCart: Int)
    func requestFailed(with errorMessage: String)
    func updatedSuccessfully(at indexPath: IndexPath)
    func updatedLikeSuccessfully(at indexPath: IndexPath, didLike: Bool)
}

protocol HomepagePresenterToView{
    
    func configUI()
    func showErrorMessage(_ errorMessage: String)
    func updateFoodAmountForCell(at indexPath:IndexPath, amount: Int)
    func reloadData()
    func startLoadingAnimation(at indexPath: IndexPath)
    func stopLoadingAnimation(at indexPath: IndexPath)
    func updateLikeButtonForCell(at indexPath: IndexPath, didLike: Bool)
}


protocol HomepagePresenterToRouter{
    static func createModule() -> UINavigationController
    func pushToDetailsVC(for food: Food)
    func pushToProfileVC()
}
