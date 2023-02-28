//
//  DetailsVC.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit
import Kingfisher

class DetailsVC: UIViewController{
    //MARK: - Properties
    
    var presenter: DetailsViewToPresenter?
    
    var food: Food?{
        didSet{
            guard let food = food else { return }
            presenter?.didLikeFood(food, didLike: food.didLike)
            imageView.kf.setImage(with: URL(string: food.foodImageURL!))
            foodNameLabel.text = food.foodName
            priceLabel.text = food.foodPrice + " TL"
            presenter?.foodDidSet(food)
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let foodNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-SemiBold", size: 25)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Medium", size: 20)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(systemName: "heart")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleLikeButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        return button
    }()
    lazy var likeBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(customView: likeButton)
        return barButton
    }()
    
    lazy var customStepper: CustomStepper = {
        let button = CustomStepper()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.viewingMode = .horizontal
        button.delegate = self
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let food = food else{ return }
        presenter?.notifyViewWillAppear(for: food)
    }
    //MARK: - Handlers
    @objc func handleLikeButtonTapped(){
        guard let food = self.food else{ return }
        print("User has liked \(food.foodName)")
        self.food!.didLike = !self.food!.didLike
        presenter?.didLikeFood(food, didLike: !food.didLike)
    }
    @objc func handleBackButtonTapped(){
        presenter?.backButtonTapped()
    }
}
//MARK: - PresenterToView Methods
extension DetailsVC: DetailsPresenterToView{
    func configUI() {
        navigationItem.rightBarButtonItem = likeBarButton
        navigationItem.title = "Details"
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
        button.setBackgroundImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        let backButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = backButton
        
        view.backgroundColor = UIColor(named: "bgColor2")
        view.addSubview(imageView)
        view.addSubview(foodNameLabel)
        view.addSubview(priceLabel)
        view.addSubview(customStepper)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // imageView
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            // foodNameLabel
            foodNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            foodNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            foodNameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            // priceLabel
            priceLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor,constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            // customStepper
            customStepper.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,constant: 50),
            customStepper.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            customStepper.heightAnchor.constraint(equalToConstant: 50),
            customStepper.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    func hideTabBar(isHidden: Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    func startLoadingAnimation() {
        customStepper.startLoadingAnimation()
    }
    func stopLoadingAnimation() {
        customStepper.stopLoadingAnimation()
    }
    func setFoodAmount(_ amount: Int) {
        self.customStepper.itemCount = amount
    }
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        navigationController?.present(alert, animated: true)
    }
    func setLikeButton(didLike: Bool) {
        let image = didLike ? UIImage(systemName: "heart.fill"): UIImage(systemName: "heart")
        likeButton.setBackgroundImage(image, for: .normal)
        
    }
    
}
//MARK: - CustomStepperDelegate
extension DetailsVC: CustomStepperDelegate{
    func countDidChange(newValue: Int) {
        guard let food = food else{ return }
        presenter?.foodAmountDidChange(for: food, amount: newValue)
    }
}
