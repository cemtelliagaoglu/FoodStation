//
//  MainTabVC.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit
import FirebaseAuth

class MainTabVC: UITabBarController{
    //MARK: - Properties
    lazy var cartButton: UIButton = {
        let button = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 30, y: -20, width: 60, height: 60))
        button.backgroundColor = UIColor(named: "bgColor1")
        button.tintColor = .white
        button.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(handleCartTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewControllers()
        configTabBar()
        checkIfUserIsLoggedIn()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    //MARK: - Handlers
    func setupViewControllers(){
        let homepageVC = HomepageRouter.createModule()
        homepageVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        let likeVC = LikeRouter.createModule()
        likeVC.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        let cartVC = CartRouter.createModule()
        cartVC.tabBarItem.image = UIImage(systemName: "cart.fill")
        self.viewControllers = [homepageVC, cartVC, likeVC]
        
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
//        tabBar.addSubview(cartButton)
        tabBar.tintColor = UIColor(named: "bgColor1")
        tabBar.backgroundColor = UIColor(named: "bgColor2")
        
    }
    @objc func handleCartTapped(){
        print("handleCartTapped")
        
    }
    
}
