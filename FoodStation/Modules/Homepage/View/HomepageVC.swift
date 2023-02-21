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
    
    var imagesBaseURLString = "http://kasimadalan.pe.hu/yemekler/resimler/"
    
    var presenter: HomepageViewToPresenter?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "bgColor2")
        return collectionView
    }()
    
    
    lazy var  logOutButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Log Out", image: nil, target: self, action: #selector(handleLogOuTapped))
        button.setTitleTextAttributes([.font: UIFont(name: "OpenSans-MediumItalic", size: 16)!], for: .normal)
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.notifyViewDidLoad()
    }
    
    //MARK: - Handlers
    @objc func handleLogOuTapped(){
        
        // declare alert controller
        let alertController = UIAlertController(title: "Are you sure to log out?", message: nil, preferredStyle: .alert)
        // add alert action
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            self.presenter?.logOutTapped()
        }))
            
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController,animated: true)
    }
}
//MARK: - UICollectionView
extension HomepageVC: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodCellIdentifier, for: indexPath) as! FoodCell
        guard let food = presenter?.foodForCell(at: indexPath.row) else{ return cell}
        if food.didLike{
            cell.didLike = true
        }else{
            cell.didLike = false
        }
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
//        navigationItem.leftBarButtonItem = logOutButton
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
    
}
//MARK: - FoodCellDelegate
extension HomepageVC: FoodCellDelegate{
    func foodAmountDidChange(indexPath: IndexPath, newValue: Int) {
        
    }
    func likeButtonTapped(indexPath: IndexPath, didLike: Bool) {
        presenter?.didLikeFood(at: indexPath.row, didLike: didLike)
    }
}
