//
//  HomepageVC.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit

class HomepageVC: UIViewController {
    //MARK: - Properties
    private let foodCellIdentifier = "foodCellIdentifier"
    
    var presenter: HomepageViewToPresenter?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "bgColor2")
        return collectionView
    }()
    
    lazy var profileButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.widthAnchor.constraint(equalToConstant: 32).isActive = true
        button.addTarget(self, action: #selector(handleProfileButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.notifyViewWillAppear()
    }
    
    //MARK: - Handlers
    @objc func handleProfileButtonTapped(){
        self.presenter?.profileButtonTapped()
    }
}
//MARK: - UICollectionView
extension HomepageVC: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodCellIdentifier, for: indexPath) as! FoodCell
        cell.viewingMode = .homepage
        guard let food = presenter?.foodForCell(at: indexPath.row) else{ return cell}
        if food.didLike{
            cell.didLike = true
        }else{
            cell.didLike = false
        }
        self.presenter?.foodAmountForCell(at: indexPath)
        cell.delegate = self
        cell.indexPath = indexPath
        cell.food = food
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 24) / 2
        return CGSize(width: width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectFood(at: indexPath.row)
    }
    
}

//MARK: - PresenterToView Methods
extension HomepageVC: HomepagePresenterToView{
    
    func configUI() {
        view.backgroundColor = UIColor(named: "bgColor1")
//        navigationItem.title = "FoodStation"
        navigationItem.leftBarButtonItem = profileButton
        let titleLabel = UILabel()
        let textAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(named: "bgColor2")!,
            .font: UIFont(name: "OpenSans-MediumItalic", size: 25)!]
        titleLabel.attributedText = NSAttributedString(string: "FoodStation", attributes: textAttributes)
        navigationItem.titleView = titleLabel
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: foodCellIdentifier)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func reloadData() {
        collectionView.reloadData()
    }

    func showErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true)
    }
    func startLoadingAnimation(at indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FoodCell
        cell?.customStepper.startLoadingAnimation()
    }
    func stopLoadingAnimation(at indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FoodCell
        cell?.customStepper.stopLoadingAnimation()
    }
    func updateFoodAmountForCell(at indexPath: IndexPath, amount: Int) {
        let cell = collectionView.cellForItem(at: indexPath) as? FoodCell
        cell?.customStepper.itemCount = amount
    }
    
}
//MARK: - FoodCellDelegate
extension HomepageVC: FoodCellDelegate{
    func foodAmountDidChange(indexPath: IndexPath, newValue: Int) {
        presenter?.updateFoodInCart(at: indexPath, amount: newValue)
    }
    func likeButtonTapped(indexPath: IndexPath, didLike: Bool) {
        presenter?.didLikeFood(at: indexPath, didLike: didLike)
    }
}
