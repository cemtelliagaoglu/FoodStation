//
//  CheckoutRouter.swift
//  FoodStation
//
//  Created by admin on 24.02.2023.
//

class CheckoutRouter: CheckoutPresenterToRouter{
    
    var view: CheckoutVC?
    
    static func createModule() -> CheckoutVC {
        let view = CheckoutVC()
        
        let presenter = CheckoutPresenter()
        let router = CheckoutRouter()
        
        view.presenter = presenter
        presenter.view = view
        view.presenter?.interactor = CheckoutInteractor()
        view.presenter?.router = router
        view.presenter?.interactor?.presenter = presenter
        
        router.view = view
        
        return view
    }
    
    func showResultVC() {
        view?.navigationController?.pushViewController(ResultVC(), animated: true)
    }
    func popVC() {
        view?.navigationController?.popViewController(animated: true)
    }
    
}
