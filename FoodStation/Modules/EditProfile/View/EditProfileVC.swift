//
//  EditProfileVC.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

import UIKit

class EditProfileVC: UIViewController{
    //MARK: - Properties
    private let cellIdentifier = "cellIdentifier"
    
    var presenter: EditProfileViewToPresenter?
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your Name"
        textField.keyboardType = .emailAddress
        textField.font = UIFont(name: "OpenSans-Medium", size: 20)
        textField.textColor = .black
        textField.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var addressTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your Address"
        textField.keyboardType = .emailAddress
        textField.font = UIFont(name: "OpenSans-Medium", size: 20)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
//        textField.minimumFontSize = 0.7
//        textField.adjustsFontSizeToFitWidth = true
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textField
    }()
    
    lazy var cardNumberTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Card Number"
        textField.keyboardType = .numberPad
        textField.textColor = .black
        textField.font = UIFont(name: "OpenSans-Medium", size: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameTextField, addressTextField, cardNumberTextField])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var saveButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.contentInsets = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        let button = UIButton(type: .custom)
        button.configuration = config
        let attributedTitle = NSAttributedString(string: "Save Changes",
                                                 attributes: [
                                                    .font: UIFont(name: "OpenSans-Medium", size: 20)!,
                                                    .foregroundColor: UIColor.white
                                                 ])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.isEnabled = false
        button.backgroundColor = .systemGray
        button.layer.borderWidth = 2
        button.addTarget(self, action: #selector(handleSaveButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
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
    @objc func formValidation(){
        guard addressTextField.hasText,
              nameTextField.hasText,
              cardNumberTextField.hasText else{
            saveButton.isEnabled = false
            saveButton.backgroundColor = .systemGray
            return
        }
        saveButton.isEnabled = true
        saveButton.backgroundColor = UIColor(named: "bgColor1")
    }
    @objc func handleSaveButtonTapped(){
        guard let name = nameTextField.text,
              let address = addressTextField.text,
              let cardNumber = cardNumberTextField.text else{ return }
        presenter?.saveChangesTapped(name: name, address: address, cardNumber: cardNumber)
    }
    @objc func handleBackButtonTapped(){
        presenter?.backButtonTapped()
    }

}
//MARK: - PresenterToView Methods
extension EditProfileVC: EditProfilePresenterToView{
    
    func configUI() {
        view.backgroundColor = UIColor(named: "bgColor2")
        navigationItem.title = "Edit Profile"
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 25))
        button.setBackgroundImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButtonTapped), for: .touchUpInside)
        let backButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = backButton
        
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(stackView)
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            // stackView
            stackView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -32),
            stackView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -32),
            // saveButton
            saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            saveButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
//            saveButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    func setUserInfo(name: String, address: String, cardNumber: String) {
        nameTextField.text = name
        addressTextField.text = address
        cardNumberTextField.text = cardNumber
    }
    func showErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        navigationController?.present(alert, animated: true)
    }
}
