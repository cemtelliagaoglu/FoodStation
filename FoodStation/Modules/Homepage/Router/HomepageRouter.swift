//
//  HomepageRouter.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit

class HomepageRouter: HomepagePresenterToRouter{
    
    static func createModule() -> UINavigationController {
        // module connection
        let view = HomepageVC()
        let presenter = HomepagePresenter()
        
        view.presenter = presenter
        view.presenter?.interactor = HomepageInteractor()
        view.presenter?.interactor?.presenter = presenter
        
        view.presenter?.view = view
        view.presenter?.router = HomepageRouter()
        // navController configurations
        let navController = UINavigationController(rootViewController: view)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "bgColor1")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "bgColor2")!,
                                               .font: UIFont(name: "OpenSans-MediumItalic", size: 30)!]
        navController.navigationBar.tintColor = UIColor(named: "bgColor1")
//        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        return navController
    }
    
    func changeVC() {
        // push viewController
        print("hiii")
        
    }
}
