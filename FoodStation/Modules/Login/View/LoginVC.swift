//
//  LoginVC.swift
//  FoodStation
//
//  Created by admin on 7.02.2023.
//

import UIKit

class LoginVC: UIViewController{
    //MARK: - Properties
    
    var presenter: LoginViewToPresenter?
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-MediumItalic",size: 30)
        label.textColor = UIColor(named: "bgColor1")
        label.text = "FoodStation"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.font = UIFont(name: "OpenSans-Medium", size: 20)
        textField.textColor = UIColor(named: "bgColor1")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
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
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .systemGray
        let attributedTitle = NSAttributedString(string: "Login",
                                                 attributes: [
                                                    .foregroundColor: UIColor.white,
                                                    .font: UIFont(name: "OpenSans-SemiBold", size: 20)!
                                                 ])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLoginTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let attributedText = NSMutableAttributedString(string: "Don't have an account? ",
                                                         attributes: [
                                                            .foregroundColor: UIColor(named: "bgColor1")!,
                                                            .font: UIFont(name: "OpenSans-MediumItalic", size: 16)!
                                                         ])
        attributedText.append(NSAttributedString(string: "Tap here to Sign Up",
                                                   attributes: [
                                                    .foregroundColor: UIColor(named: "bgColor3")!,
                                                    .font: UIFont(name: "OpenSans-Medium", size: 16)!
                                                   ]))
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = attributedText
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSignUpTapped))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
    
    //MARK: - Handlers
    
    @objc func handleLoginTapped(){
        if let email = emailTextField.text, let password = passwordTextField.text{
            presenter?.loginTapped(with: email, password)
        }
    }
    @objc func handleSignUpTapped(){
        presenter?.signUpTapped()
    }
    
    @objc func formValidation(){
        guard emailTextField.hasText,
              passwordTextField.hasText,
              passwordTextField.text!.count >= 6 else{
            loginButton.isEnabled = false
            loginButton.backgroundColor = .systemGray
            return
        }
        loginButton.isEnabled = true
        loginButton.backgroundColor = UIColor(named: "bgColor1")
    }
}
//MARK: - PresenterToView Methods
extension LoginVC: LoginPresenterToView{
    
    func configUI() {
        view.backgroundColor = UIColor(named: "bgColor2")
        view.addSubview(loginButton)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        view.addSubview(signUpLabel)
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            // loginButton
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 100),
            // passwordTextField
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -50),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            // emailTextField
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            // signUpLabel
            signUpLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 32),
            signUpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            signUpLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
//            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            titleLabel.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -50)
        ])
    }
    
    func showAuthenticationError(_ error: Error) {
        let alert = UIAlertController(title: "Failed to Login", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        present(alert, animated: true)
    }
}
