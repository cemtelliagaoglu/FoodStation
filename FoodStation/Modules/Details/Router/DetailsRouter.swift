//
//  DetailsRouter.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

class DetailsRouter: DetailsPresenterToRouter{
    
    var view: DetailsVC?
    
    static func createModule() -> DetailsVC {
        let view = DetailsVC()
        let presenter = DetailsPresenter()
        let router = DetailsRouter()
        
        view.presenter = presenter
        presenter.view = view
        view.presenter?.interactor = DetailsInteractor()
        view.presenter?.interactor?.presenter = presenter
        view.presenter?.router = router
        
        router.view = view
        return view
    }
    
    func popVC() {
        view?.navigationController?.popToRootViewController(animated: true)
    }
}
