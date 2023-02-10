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
    
    var foodList = [Food]()
    var imagesBaseURLString = "http://kasimadalan.pe.hu/yemekler/resimler/"
    
    var presenter: HomepageViewToPresenter?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(named: "bgColor1")
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
        
//        APIService.loadCart(for: "deneme")
        configUI()
        loadData()
    }
    
    //MARK: - Handlers
    func configUI(){
        view.backgroundColor = UIColor(named: "bgColor1")
        navigationItem.title = "FoodStation"
        navigationItem.leftBarButtonItem = logOutButton
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
    
    func loadData(){
        presenter?.loadData()
    }

    @objc func handleLogOuTapped(){
        
        // declare alert controller
        let alertController = UIAlertController(title: "Are you sure to log out?", message: nil, preferredStyle: .alert)
        // add alert action
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            self.presenter?.logOutTapped()
//            self.presenter?.logOutTapped(from: navController)
        }))
            
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController,animated: true)
    }
}
//MARK: - UICollectionView
extension HomepageVC: UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: foodCellIdentifier, for: indexPath) as! FoodCell
        
        cell.food = foodList[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 32) / 3
        return CGSize(width: width, height: 100)
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
        presenter?.didSelectFood(foodList[indexPath.row])
    }
    
}

//MARK: - PresenterToView Methods
extension HomepageVC: HomepagePresenterToView{
    
    func sendFetchedData(_ foods: [Food]) {
        self.foodList = foods
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    func failedToSignOut() {
        let alert = UIAlertController(title: "Error", message: "Failed To Sign Out", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Try Again", style: .default) { action in
            self.presenter?.logOutTapped()
        })
        
        present(alert, animated: true)
        
    }
    
}
