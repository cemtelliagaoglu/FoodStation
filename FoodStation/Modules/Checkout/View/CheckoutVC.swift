//
//  CheckoutVC.swift
//  FoodStation
//
//  Created by admin on 24.02.2023.
//

import UIKit

class CheckoutVC: UIViewController {
    //MARK: - Properties
    private let cellIdentifier = "cellIdentifier"
     
    var presenter: CheckoutViewToPresenter?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor(named: "bgColor2")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 120
        return tableView
    }()
    let creditCardTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Credit Card"
        label.textColor = .black
        label.font = UIFont(name: "OpenSans-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var creditCardLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Medium", size: 16)
        label.textColor = .black
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var changeCreditCardLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 14)
        label.textColor = UIColor(named: "bgColor1")
        label.text = "Change Your Credit Card"
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleChangeCreditCardTapped))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let deliveryAddressTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Delivery Address"
        label.textColor = .black
        label.font = UIFont(name: "OpenSans-Regular", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deliveryAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Medium", size: 16)
        label.textColor = .black
        label.text = ""
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var changeAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 14)
        label.textColor = UIColor(named: "bgColor1")
        label.text = "Change Your Delivery Address"
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleChangeAddressTapped))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var addressContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [deliveryAddressLabel, changeAddressLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var creditCardContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let stackView = UIStackView(arrangedSubviews: [creditCardLabel, changeCreditCardLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
        
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Medium", size: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "0 TL"
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var orderButton: UIButton = {
        let button = UIButton(type: .custom)
        let attributedTitle = NSAttributedString(string: "Order and Pay",
                                                 attributes: [
                                                    .font: UIFont(name: "OpenSans-Medium", size: 20)!,
                                                    .foregroundColor: UIColor(named: "bgColor1")!
                                                 ])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(handleOrderButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        presenter?.notifyViewWillAppear()
    }
    
    //MARK: - Handler
    @objc func handleChangeAddressTapped(){
        
        let alert = UIAlertController(title: "Enter your new address", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Address"
        })
        let changeAddressAction = UIAlertAction(title: "Change", style: .default){ action in
            guard let textField = alert.textFields?[0] else { return }
            self.presenter?.changeAddressTapped(newAddress: textField.text!)
        }
        alert.addAction(changeAddressAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    
    @objc func handleChangeCreditCardTapped(){
        
        let alert = UIAlertController(title: "Enter your card number", message: nil, preferredStyle: .alert)
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Card Number"
        })
        let changeAddressAction = UIAlertAction(title: "Change", style: .default){ action in
            guard let textField = alert.textFields?[0] else { return }
            self.presenter?.changeCreditCardTapped(newCardNumber: textField.text!)
        }
        alert.addAction(changeAddressAction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(alert, animated: true)
    }
    @objc func handleOrderButtonTapped(){
        presenter?.orderButtonPressed()
    }
}
//MARK: - TableView Methods
extension CheckoutVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CartTableViewCell
        cell.customStepper.isHidden = true
        guard let food = presenter?.foodForCell(at: indexPath.row) else{ return cell}
        let imageURL = "http://kasimadalan.pe.hu/yemekler/resimler/\(food.foodImageName)"
        
        cell.foodImageView.kf.setImage(with: URL(string: imageURL)!)
        cell.nameLabel.text = food.foodName
        cell.priceLabel.text = "\(food.foodPrice) TL x \(food.foodAmount)"
        return cell
    }

}
//MARK: - PresenterToView Methods
extension CheckoutVC: CheckoutPresenterToView{
    
    func configUI() {
        view.backgroundColor = UIColor(named: "bgColor2")
        navigationItem.title = "Checkout"
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(deliveryAddressTitleLabel)
        view.addSubview(addressContainerView)
        view.addSubview(creditCardTitleLabel)
        view.addSubview(creditCardContainerView)
        view.addSubview(tableView)
        view.addSubview(totalPriceLabel)
        view.addSubview(orderButton)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // deliveryAddressTitleLabel
            deliveryAddressTitleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 16),
            deliveryAddressTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            // addressContainerView
            addressContainerView.topAnchor.constraint(equalTo: deliveryAddressTitleLabel.bottomAnchor, constant: 8),
            addressContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            addressContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -32),
            addressContainerView.heightAnchor.constraint(equalToConstant: 60),
            
            // creditCardTitleLabel
            creditCardTitleLabel.topAnchor.constraint(equalTo: addressContainerView.bottomAnchor, constant: 16),
            creditCardTitleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 40),
            
            // creditCardContainerView
            creditCardContainerView.topAnchor.constraint(equalTo: creditCardTitleLabel.bottomAnchor, constant: 8),
            creditCardContainerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            creditCardContainerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -32),
            creditCardContainerView.heightAnchor.constraint(equalToConstant: 60),
            // collectionView
            tableView.topAnchor.constraint(equalTo: creditCardContainerView.bottomAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalPriceLabel.topAnchor, constant: -16),
           // totalPriceLabel
            totalPriceLabel.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -4),
            totalPriceLabel.centerXAnchor.constraint(equalTo: orderButton.centerXAnchor),
            // orderButton
            orderButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            orderButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -35),
            orderButton.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
    func setUserInfo(address: String, cardNumber: String) {
        deliveryAddressLabel.text = address
        creditCardLabel.text = cardNumber
    }
    func setPriceLabel(_ price: String) {
        totalPriceLabel.text = price
    }
    func reloadData() {
        tableView.reloadData()
    }
    func showErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        navigationController?.present(alert, animated: true)
    }
}
