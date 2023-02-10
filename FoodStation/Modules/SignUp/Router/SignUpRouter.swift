//
//  SignUpRouter.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

import UIKit

class SignUpRouter: SignUpPresenterToRouter{
    
    var view: SignUpVC?
    
    static func createModule() -> SignUpVC {
        let view = SignUpVC()
        
        let presenter = SignUpPresenter()
        let router = SignUpRouter()
        
        view.presenter = presenter
        presenter.view = view
        view.presenter?.interactor = SignUpInteractor()
        view.presenter?.router = router
        view.presenter?.interactor?.presenter = presenter
        
        router.view = view
        
        return view
    }
    
    func popVC() {
        view?.navigationController?.popToRootViewController(animated: true)
    }
    
    func pushToMainTabVC(){
        view?.navigationController?.pushViewController(MainTabVC(), animated: true)
    }
    
}
