//
//  LikeVC.swift
//  FoodStation
//
//  Created by admin on 21.02.2023.
//

import UIKit

class LikeVC: UIViewController{
    //MARK: - Properties
    private let cellIdentifier = "cellIdentifier"
    
    var presenter: LikeViewToPresenter?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 46, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
extension LikeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FoodCell
        cell.viewingMode = .like
        cell.delegate = self
        cell.indexPath = indexPath
        guard let food = presenter?.foodForCell(at: indexPath.row) else{ return cell}
        cell.food = food
        cell.didLike = food.didLike
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        return CGSize(width: width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectFood(at: indexPath.row)
    }
}
//MARK: - PresenterToView Methods
extension LikeVC: LikePresenterToView{
    
    func configUI() {
        view.backgroundColor = UIColor(named: "bgColor2")
        navigationItem.title = "Liked Foods"
        
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        view.addSubview(collectionView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
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
}
//MARK: - FoodCellDelegate
extension LikeVC: FoodCellDelegate{
    func foodAmountDidChange(indexPath: IndexPath, newValue: Int) {
        // no need to use
    }
    func likeButtonTapped(indexPath: IndexPath, didLike: Bool) {
        presenter?.likeButtonTapped(at: indexPath.row)
    }
}
