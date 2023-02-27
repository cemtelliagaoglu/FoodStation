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
        view?.navigationController?.present(ResultVC(), animated: true)
        view?.tabBarController?.selectedIndex = 0
        view?.navigationController?.popViewController(animated: false)
    }
    
}
