//
//  MainTabVC.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit

class MainTabVC: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        configTabBar()
    }
    
    func setupViewControllers(){
        let homepageVC = HomepageRouter.createModule()
        
        homepageVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        let detailsVC = DetailsVC()
        detailsVC.tabBarItem.image = UIImage(systemName: "person.fill")
        self.viewControllers = [homepageVC, detailsVC]
    }
    
    func configTabBar(){
        tabBar.tintColor = UIColor(named: "bgColor1")
        tabBar.backgroundColor = UIColor(named: "bgColor2")
        
    }
    
}
