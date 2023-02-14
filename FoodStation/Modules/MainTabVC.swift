//
//  MainTabVC.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit
import FirebaseAuth

class MainTabVC: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        configTabBar()
        checkIfUserIsLoggedIn()
        
    }
    
    func setupViewControllers(){
        let homepageVC = HomepageRouter.createModule()
        homepageVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        let profileVC = ProfileRouter.createModule()
        profileVC.tabBarItem.image = UIImage(systemName: "person.fill")
        
        let cartVC = CartRouter.createModule()
        cartVC.tabBarItem.image = UIImage(systemName: "cart.fill")
        self.viewControllers = [homepageVC, cartVC, profileVC]
        
    }
    
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                // present login controller
                let navController = LoginRouter.createModule()
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true)
            }
        }
    }
    func configTabBar(){
        tabBar.tintColor = UIColor(named: "bgColor1")
        tabBar.backgroundColor = UIColor(named: "bgColor2")
        
    }
    
}
