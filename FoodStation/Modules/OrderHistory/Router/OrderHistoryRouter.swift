//
//  OrderHistoryRouter.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

class OrderHistoryRouter: OrderHistoryPresenterToRouter{
    
    var viewController: OrderHistoryVC?
    
    static func createModule() -> OrderHistoryVC {
        let view = OrderHistoryVC()
        
        let presenter = OrderHistoryPresenter()
        let router = OrderHistoryRouter()
        
        view.presenter = presenter
        presenter.view = view
        view.presenter?.interactor = OrderHistoryInteractor()
        view.presenter?.router = router
        view.presenter?.interactor?.presenter = presenter
        
        router.viewController = view
        
        return view
    }
}
