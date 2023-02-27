//
//  ResultVC.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

import UIKit
import Lottie

class ResultVC: UIViewController{
    //MARK: - Properties
    private var animationView: LottieAnimationView = {
        let animationView = LottieAnimationView(name: "order-confirmed")
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()
        
    lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-SemiBold", size: 30)
        label.textColor = .white
        label.numberOfLines = 0
        let attributedText = NSMutableAttributedString(string: "We Received Your Order!\n", attributes: [
                        .font: UIFont(name: "OpenSans-SemiBold", size: 30)!,
                        .foregroundColor: UIColor.white
                    ])
        attributedText.append(NSAttributedString(string: "It will be with you soon...",
                                                 attributes: [
                                                    .font: UIFont(name: "OpenSans-Medium", size: 20)!,
                                                    .foregroundColor: UIColor.white
                                                 ]))
        label.attributedText = attributedText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    //MARK: - Handler
    func setupView(){
        view.backgroundColor = UIColor(named: "bgColor1")
        
        view.addSubview(animationView)
        view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            // animationView
            animationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            // messageLabel
            messageLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
