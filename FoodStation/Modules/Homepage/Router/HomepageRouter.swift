//
//  HomepageRouter.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit

class HomepageRouter: HomepagePresenterToRouter{
    
    var navController: UINavigationController?
    
    static func createModule() -> UINavigationController {
        // module connection
        let view = HomepageVC()
        let presenter = HomepagePresenter()
        let router = HomepageRouter()
        
        view.presenter = presenter
        view.presenter?.interactor = HomepageInteractor()
        view.presenter?.interactor?.presenter = presenter
        
        view.presenter?.view = view
        view.presenter?.router = router
        // navController configurations
        let navController = UINavigationController(rootViewController: view)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "bgColor1")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "bgColor2")!,
                                               .font: UIFont(name: "OpenSans-MediumItalic", size: 25)!]
        navController.navigationBar.tintColor = UIColor(named: "bgColor2")
//        navController.navigationBar.prefersLargeTitles = true
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        
        router.navController = navController
        
        return navController
    }
 
    func pushToDetailsVC(for food: Food) {
        let detailsVC = DetailsRouter.createModule()
        detailsVC.food = food
        navController?.pushViewController(detailsVC, animated: true)
    }
    
    func pushToProfileVC() {
        let profileVC = ProfileRouter.createModule()
        navController?.pushViewController(profileVC, animated: true)
        navController?.modalPresentationStyle = .fullScreen
    }
}
