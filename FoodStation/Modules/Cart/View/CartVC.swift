//
//  CartVC.swift
//  FoodStation
//
//  Created by admin on 8.02.2023.
//

import UIKit
import Kingfisher

class CartVC: UIViewController{
    //MARK: - Properties
    private let cellIdentifier = "cellIdentifier"
    
    var presenter: CartViewToPresenter?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "bgColor2")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 120
        return tableView
    }()
    
    lazy var checkoutButton: UIButton = {
        let button = UIButton(type: .custom)
        let attributedTitle = NSAttributedString(string: "Proceed to Checkout", attributes: [ .font: UIFont(name: "OpenSans-SemiBold", size: 20)!, .foregroundColor: UIColor(named: "bgColor2")!])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = UIColor(named: "bgColor1")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleCheckoutTapped), for: .touchUpInside)
        button.layer.cornerRadius = 20
        return button
    }()
    
    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Medium", size: 18)
        label.textColor = .black
        label.text = "0 TL"
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var deleteAllCartButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "trash.fill"), style: .plain, target: self, action: #selector(handleDeleteAllTapped))
        return button
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
    @objc func handleCheckoutTapped(){
        presenter?.checkoutTapped()
    }
    @objc func handleDeleteAllTapped(){
        let alert = UIAlertController(title: "Delete", message: "Are you sure to delete all cart?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default){ action in
            self.presenter?.deleteAllCartTapped()
        })
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        present(alert, animated: true)
    }
}
//MARK: - UITableView Methods
extension CartVC: UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CartTableViewCell
        guard let food = presenter?.foodForCell(at: indexPath.row) else{ return cell}
        let imageURL = "http://kasimadalan.pe.hu/yemekler/resimler/\(food.foodImageName)"
        
        cell.delegate = self
        cell.indexPath = indexPath
        cell.foodImageView.kf.setImage(with: URL(string: imageURL)!)
        cell.nameLabel.text = food.foodName
        cell.priceLabel.text = "\(food.foodPrice) TL"
        cell.customStepper.itemCount = Int(food.foodAmount)!
        return cell
    }
}
//MARK: - PresenterToView Methods
extension CartVC: CartPresenterToView{
    
    func configUI() {
        view.backgroundColor = UIColor(named:"bgColor2")
        navigationItem.title = "Cart"
        navigationItem.rightBarButtonItem = deleteAllCartButton
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(checkoutButton)
        view.addSubview(totalPriceLabel)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            checkoutButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            checkoutButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -38),
            checkoutButton.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 2) + 50),
            totalPriceLabel.centerYAnchor.constraint(equalTo: checkoutButton.centerYAnchor),
            totalPriceLabel.trailingAnchor.constraint(equalTo: checkoutButton.leadingAnchor, constant: -16),
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: checkoutButton.topAnchor, constant: -8)
        ])
    }
    func setPriceLabel(with price: String) {
        totalPriceLabel.text = price
        totalPriceLabel.isHidden = price == "0 TL"
    }
    func reloadData() {
        tableView.reloadData()
        presenter?.shouldUpdatePriceLabel()
    }
    func showErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        navigationController?.present(alert, animated: true)
    }
    
    func startLoadingAnimation(at indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CartTableViewCell
        cell?.customStepper.startLoadingAnimation()
    }
    func stopLoadingAnimation(at indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? CartTableViewCell
        cell?.customStepper.stopLoadingAnimation()
    }
}
//MARK: - CartTableViewCellDelegate
extension CartVC: CartTableViewCellDelegate{
    func foodCountDidChange(at indexPath: IndexPath, newValue: Int) {
        presenter?.amountDidChange(at: indexPath, newAmount: newValue)
    }
}
