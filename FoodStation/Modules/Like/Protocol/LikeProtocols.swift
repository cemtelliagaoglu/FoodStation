//
//  LikeProtocols.swift
//  FoodStation
//
//  Created by admin on 21.02.2023.
//

import UIKit

protocol LikeViewToPresenter{
    var interactor: LikePresenterToInteractor? { get set }
    var router: LikePresenterToRouter? { get set }
    var view: LikePresenterToView? { get set }
    
    func notifyViewDidLoad()
    func notifyViewWillAppear()
    func foodForCell(at index: Int) -> Food?
    func didSelectFood(at index: Int)
    func numberOfItems() -> Int?
    func likeButtonTapped(at index: Int)
}

protocol LikePresenterToInteractor{
    var presenter: LikeInteractorToPresenter? { get set }
    func requestLoadingLikedFoods()
    func foodInfo(at index: Int) -> Food?
    func numberOfFoods() -> Int?
    func removeLikedFood(at index: Int)
}
protocol LikeInteractorToPresenter{
    func loadedLikedFoodsSuccessfully()
    func removedLikeSuccessfully()
    func requestFailed(with errorMessage: String)
}

protocol LikePresenterToView{
    
    func configUI()
    func reloadData()
    func showErrorMessage(_ errorMessage: String)
}

protocol LikePresenterToRouter{
    static func createModule() -> UINavigationController
    func pushToDetails(for food: Food)
}
