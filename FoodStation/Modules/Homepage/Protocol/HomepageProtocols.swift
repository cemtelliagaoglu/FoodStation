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
    
    func changeVC()
}

protocol HomepagePresenterToInteractor{
    var presenter: HomepageInteractorToPresenter? { get set }
    
    func loadData()
    
}

protocol HomepageInteractorToPresenter{
    
    func sendFetchedData(_ foods: [Food])
//    func sendFetchedData(_ food: Food, image: UIImage)
//    func deleteFromCard(_ foodId: Int)
}

protocol HomepagePresenterToView{
    
    func sendFetchedData(_ foods: [Food])
//    func sendFetchedData(_ foods: Food, image: UIImage)
}


protocol HomepagePresenterToRouter{
    static func createModule() -> UINavigationController
    
    func changeVC()
}
