//
//  DetailsProtocols.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit

protocol DetailsViewToPresenter{
    var interactor: DetailsPresenterToInteractor? { get set }
    var view: DetailsPresenterToView? { get set }
    var router: DetailsPresenterToRouter? { get set }
    
    func loadData()
//    func loadCardInfo()
    
    func changeVC()
}

protocol DetailsPresenterToInteractor{
    var presenter: DetailsInteractorToPresenter? { get set }
    
    func loadData()
    
}

protocol DetailsInteractorToPresenter{
    
    func sendFetchedData(_ foods: [Food])
//    func sendFetchedData(_ food: Food, image: UIImage)
//    func deleteFromCard(_ foodId: Int)
}

protocol DetailsPresenterToView{
    
    func sendFetchedData(_ foods: [Food])
//    func sendFetchedData(_ foods: Food, image: UIImage)
}


protocol DetailsPresenterToRouter{
    static func createModule() -> UINavigationController
    
    func changeVC()
}
