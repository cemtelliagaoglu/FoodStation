//
//  LoginRouter.swift
//  FoodStation
//
//  Created by admin on 7.02.2023.
//

import UIKit

class LoginRouter: LoginPresenterToRouter{

    var navController: UINavigationController?
    
    static func createModule() -> UINavigationController {
        // module connection
        let view = LoginVC()
        let presenter = LoginPresenter()
        let router = LoginRouter()
        
        view.presenter = presenter
        view.presenter?.interactor = LoginInteractor()
        presenter.view = view
        view.presenter?.interactor?.presenter = presenter
        
        view.presenter?.router = router
        
        // navController configurations
        let navController = UINavigationController(rootViewController: view)
        navController.isNavigationBarHidden = true
        
        router.navController = navController
        return navController
    }
    
    func goToSignUpVC() {
        navController?.pushViewController(SignUpRouter.createModule(), animated: true)
    }
    
    func goToMainTabVC() {
        navController?.dismiss(animated: true)
    }
}
