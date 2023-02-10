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
    
    func loadData()
//    func loadCardInfo()
    func logOutTapped()
    func didSelectFood(_ food: Food)
}

protocol HomepagePresenterToInteractor{
    var presenter: HomepageInteractorToPresenter? { get set }
    
    func loadData()
    func requestSignOut()
}

protocol HomepageInteractorToPresenter{
    
//    func deleteFromCard(_ foodId: Int)
    func loadDataSucceed(with foods: [Food])
    func loadDataFailed()
    
    func requestSignOutSucceed()
    func requestSignOutFailed()
    
}

protocol HomepagePresenterToView{
    
    func sendFetchedData(_ foods: [Food])
    func failedToSignOut()
//    func sendFetchedData(_ foods: Food, image: UIImage)
}


protocol HomepagePresenterToRouter{
    static func createModule() -> UINavigationController
    
    func pushToLoginVC()
    func pushToDetailsVC(for food: Food)
}
