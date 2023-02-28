//
//  SignUpVC.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

import UIKit

class SignUpVC: UIViewController{
    //MARK: - Properties
    var presenter: SignUpViewToPresenter?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-MediumItalic",size: 30)
        label.textColor = UIColor(named: "bgColor1")
        label.text = "Sign Up"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Your Name"
        textField.keyboardType = .emailAddress
        textField.font = UIFont(name: "OpenSans-Medium", size: 20)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textField
    }()
    
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.font = UIFont(name: "OpenSans-Medium", size: 20)
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.minimumFontSize = 0.5
        textField.adjustsFontSizeToFitWidth = true
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.keyboardType = .emailAddress
        textField.font = UIFont(name: "OpenSans-Medium", size: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
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
        textField.minimumFontSize = 0.8
        textField.adjustsFontSizeToFitWidth = true
        textField.addTarget(self, action: #selector(formValidation), for: .editingChanged)
        return textField
    }()

    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemGray
        let attributedTitle = NSAttributedString(string: "Sign Up",
                                                 attributes: [
                                                    .foregroundColor: UIColor.white,
                                                    .font: UIFont(name: "OpenSans-SemiBold", size: 20)!
                                                 ])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleSignUpTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Already have an account? ",
                                                         attributes: [
                                                            .foregroundColor: UIColor(named: "bgColor1")!,
                                                            .font: UIFont(name: "OpenSans-MediumItalic", size: 16)!
                                                         ])
        attributedText.append(NSAttributedString(string: "Tap here to Login",
                                                   attributes: [
                                                    .foregroundColor: UIColor(named: "bgColor3")!,
                                                    .font: UIFont(name: "OpenSans-Medium", size: 16)!
                                                   ]))
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = attributedText
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLoginTapped))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,nameTextField, emailTextField, passwordTextField, addressTextField])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
    
    //MARK: - Handlers
    
    @objc func handleSignUpTapped(){
        if let email = emailTextField.text,
           let password = passwordTextField.text,
           let name = nameTextField.text,
           let address = addressTextField.text{
            presenter?.signUpTapped(with: email, password, name, address: address)
        }
        
    }
    @objc func handleLoginTapped(){
        presenter?.loginTapped()
    }
    
    @objc func formValidation(){
        guard emailTextField.hasText,
              passwordTextField.hasText,
              addressTextField.hasText,
              passwordTextField.text!.count >= 6 else{
            signUpButton.isEnabled = false
            signUpButton.backgroundColor = .systemGray
            return
        }
        signUpButton.isEnabled = true
        signUpButton.backgroundColor = UIColor(named: "bgColor1")
    }
    
}
//MARK: - PresenterToView Methods
extension SignUpVC: SignUpPresenterToView{
    func signUpFailed(with error: Error) {
        let alert = UIAlertController(title: "Failed to Sign Up", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true)
    }
    
    func configUI() {
        view.backgroundColor = UIColor(named: "bgColor2")
        
        view.addSubview(stackView)
        
        view.addSubview(signUpButton)
        view.addSubview(loginLabel)
        
        NSLayoutConstraint.activate([
            // stackView
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant:  -32),
            // signUpButton
            signUpButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signUpButton.widthAnchor.constraint(equalToConstant: 100),
            // loginLabel
            loginLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 32),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
        
    }
}
