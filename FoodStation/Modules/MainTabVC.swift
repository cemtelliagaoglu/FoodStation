//
//  MainTabVC.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit

class MainTabVC: UITabBarController{
    //MARK: - Properties
    lazy var cartButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .white
        button.tintColor = UIColor(named: "bgColor1")
        button.setImage(UIImage(systemName: "cart.fill"), for: .normal)
        button.layer.cornerRadius = 35
        button.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(handleCartTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarLayer()
        setupViewControllers()
        configTabBar()
        checkIfUserIsLoggedIn()
        
    }
    //MARK: - Handlers
    func setupViewControllers(){
        let homepageVC = HomepageRouter.createModule()
        homepageVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        let likeVC = LikeRouter.createModule()
        likeVC.tabBarItem.image = UIImage(systemName: "heart.fill")
        
        let cartVC = CartRouter.createModule()
        self.viewControllers = [homepageVC, cartVC, likeVC]
        
    }
    
    func checkIfUserIsLoggedIn(){
        FirebaseService.checkLoginStatus { isLoggedIn in
            DispatchQueue.main.async {
                if !isLoggedIn{
                    // present login controller
                    let navController = LoginRouter.createModule()
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true)
                }
            }
        }
    }
    func configTabBar(){
        
        tabBar.addSubview(cartButton)
        
        tabBar.tintColor = UIColor(named: "bgColor1")
        tabBar.backgroundColor = .clear

        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .clear
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        NSLayoutConstraint.activate([
            cartButton.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: 35),
            cartButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            cartButton.widthAnchor.constraint(equalToConstant: 70),
            cartButton.heightAnchor.constraint(equalToConstant: 70),
        ])
        
    }
    @objc func handleCartTapped(){
        self.selectedIndex = 1
    }
    
    func setupTabBarLayer(){
        let center = self.tabBar.bounds.width / 2
        let layer = CAShapeLayer()
        layer.path = createCurve(at: center, with: 35).cgPath
        layer.fillColor = UIColor.white.cgColor
        layer.strokeColor = UIColor(named: "bgColor1")?.cgColor
        self.tabBar.layer.addSublayer(layer)
    }
    
    func createCurve(at center: CGFloat, with radius: CGFloat) -> UIBezierPath {
        // 1
        let path = UIBezierPath()
        path.move(to: .zero)
        // 2
        path.addLine(to: CGPoint(x: center - (2 * radius), y: 0))
        // 3
        path.addQuadCurve(to: CGPoint(x: center - radius, y: (radius / 2)),
                          controlPoint: CGPoint(x: center - radius - (radius / 8), y: 0))
        // 4
        path.addCurve(to: CGPoint(x: center + radius, y: (radius / 2)),
                      controlPoint1: CGPoint(x: center - radius + (radius / 4), y: radius + (radius / 2)),
                      controlPoint2: CGPoint(x: center + radius - (radius / 4), y: radius + (radius / 2)))
        // 5
        path.addQuadCurve(to: CGPoint(x: center + (radius * 2), y: 0),
                          controlPoint: CGPoint(x: center + radius + (radius / 8), y: 0))
        // 6
        path.addLine(to: CGPoint(x: tabBar.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: tabBar.bounds.width, y: tabBar.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: tabBar.bounds.height))
        path.close()
        return path
    }
    
}
