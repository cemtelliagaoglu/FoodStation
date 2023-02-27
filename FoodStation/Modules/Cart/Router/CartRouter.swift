//
//  CartRouter.swift
//  FoodStation
//
//  Created by admin on 8.02.2023.
//

import UIKit

class CartRouter: CartPresenterToRouter{
    
    var navController: UINavigationController?
    
    static func createModule() -> UINavigationController {
        let view = CartVC()
        let presenter = CartPresenter()
        let router = CartRouter()
        
        view.presenter = presenter
        presenter.view = view
        view.presenter?.interactor = CartInteractor()
        view.presenter?.interactor?.presenter = presenter
        
        view.presenter?.router = router
        
        // navController configurations
        let navController = UINavigationController(rootViewController: view)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "bgColor1")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "bgColor2")!,
                                               .font: UIFont(name: "OpenSans-MediumItalic", size: 25)!]
        navController.navigationBar.tintColor = .white
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        navController.navigationItem.hidesBackButton = false
        
        router.navController = navController
        
        return navController
    }
    
    func pushToHomepage() {
        navController?.tabBarController?.selectedIndex = 0
    }
    
    func pushToCheckout() {
        let checkoutVC = CheckoutRouter.createModule()
        navController?.pushViewController(checkoutVC, animated: true)
    }
    
}
