//
//  OrderHistoryVC.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

import UIKit

class OrderHistoryVC: UIViewController{
    //MARK: - Properties
    private let cellIdentifier = "cellIdentifier"
    
    var presenter: OrderHistoryViewToPresenter?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 46, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(OrderCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = UIColor(named: "bgColor2")
        return collectionView
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
}
//MARK: - CollectionView Methods
extension OrderHistoryVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! OrderCell
        guard let order = presenter?.orderForCell(at: indexPath.row) else { return cell}
        cell.order = order
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 46, right: 16)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        return CGSize(width: width, height: 80)
    }
}

//MARK: - PresenterToView Methods
extension OrderHistoryVC: OrderHistoryPresenterToView{
    
    func configUI() {
        view.backgroundColor = UIColor(named: "bgColor2")
        navigationItem.title = "Order History"
        
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func showErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        navigationController?.present(alert, animated: true)
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
}
