//
//  LikeRouter.swift
//  FoodStation
//
//  Created by admin on 21.02.2023.
//

import UIKit

class LikeRouter: LikePresenterToRouter{
    
    var navigationController: UINavigationController?
    
    static func createModule() -> UINavigationController {
        let view = LikeVC()
        let presenter = LikePresenter()
        let router = LikeRouter()
        
        // navController configurations
        let navController = UINavigationController(rootViewController: view)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "bgColor1")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "bgColor2")!,
                                               .font: UIFont(name: "OpenSans-MediumItalic", size: 25)!]
        navController.navigationBar.tintColor = UIColor(named: "bgColor2")
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        
        router.navigationController = navController
        return navController
    }
    
}
