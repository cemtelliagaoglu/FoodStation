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
    private let searchCellIdentifier = "searchCellIdentifier"
    
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
        let button = UIButton(frame: .init(x: 0, y: 0, width: 35, height: 35))
        button.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        button.addTarget(self, action: #selector(handleProfileButtonTapped), for: .touchUpInside)
        button.tintColor = .white
        let barButton = UIBarButtonItem(customView: button)
        return barButton
    }()
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.searchTextField.borderStyle = .roundedRect
        searchBar.searchTextField.returnKeyType = .search
        searchBar.searchTextField.layer.borderWidth = 2
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.font = UIFont(name: "OpenSans-Regular", size: 18)
        searchBar.searchTextField.textColor = .black
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
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
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return presenter?.numberOfItems() ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: searchCellIdentifier, for: indexPath) as! SearchCell
            cell.delegate = self
            return cell
        }else{
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
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 80)
        }else{
            let width = (UIScreen.main.bounds.width - 24) / 2
            return CGSize(width: width, height: 150)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0{
            return 0
        }else{
            return 8
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0{
            return UIEdgeInsets(top: 4, left: 8, bottom: 8, right: 8)
        }else{
            return UIEdgeInsets(top: 4, left: 8, bottom: 38, right: 8)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectFood(at: indexPath.row)
    }
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        print(scrollView)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath <= IndexPath(row: 8, section: 1){
            if searchBar.searchTextField.isEditing {
                searchBar.isHidden = false
            }else{
                searchBar.isHidden = true
            }
        }else{
            searchBar.isHidden = false
        }
    }
}
//MARK: - SearchBarDelegate
extension HomepageVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            presenter?.searchTextDidChange(searchText: searchText)
            searchBar.endEditing(true)
        }else{
            presenter?.searchTextDidChange(searchText: searchText)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

//MARK: - PresenterToView Methods
extension HomepageVC: HomepagePresenterToView{
    
    func configUI() {
        view.backgroundColor = UIColor(named: "bgColor2")
        navigationItem.leftBarButtonItem = profileButton
        let titleLabel = UILabel()
        let textAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(named: "bgColor2")!,
            .font: UIFont(name: "OpenSans-MediumItalic", size: 25)!]
        titleLabel.attributedText = NSAttributedString(string: "FoodStation", attributes: textAttributes)
        navigationItem.titleView = titleLabel
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: foodCellIdentifier)
        collectionView.register(SearchCell.self, forCellWithReuseIdentifier: searchCellIdentifier)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            // searchBar
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -16),
            // collectionView
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func reloadData() {
        collectionView.reloadSections(IndexSet(integer: 1))
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
    func updateLikeButtonForCell(at indexPath: IndexPath, didLike: Bool) {
        let cell = collectionView.cellForItem(at: indexPath) as? FoodCell
        cell?.didLike = didLike
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
//MARK: - SearchCellDelegate
extension HomepageVC: SearchCellDelegate{
    func textDidChange(text: String) {
        presenter?.searchTextDidChange(searchText: text)
    }
}
