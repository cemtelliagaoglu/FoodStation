//
//  LoginVC.swift
//  FoodStation
//
//  Created by admin on 7.02.2023.
//

import UIKit

class LoginVC: UIViewController{
    //MARK: - Properties
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.keyboardType = .emailAddress
        textField.font = UIFont(name: "OpenSans-Medium", size: 20)
        textField.textColor = UIColor(named: "textColor")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.keyboardType = .emailAddress
        textField.font = UIFont(name: "OpenSans-Medium", size: 20)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor(named: "bgColor1")
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
                                                            .foregroundColor: UIColor(named: "textColor")!,
                                                            .font: UIFont(name: "OpenSans-MediumItalic", size: 16)!
                                                         ])
        attributedText.append(NSAttributedString(string: "Click here to Register",
                                                   attributes: [
                                                    .foregroundColor: UIColor(named: "bgColor1")!,
                                                    .font: UIFont(name: "OpenSans-Medium", size: 16)!
                                                   ]))
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.attributedText = attributedText
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSignUpTapped))
        tapGesture.numberOfTapsRequired = 1
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    //MARK: - Handlers
    
    @objc func handleLoginTapped(){
        
    }
    @objc func handleSignUpTapped(){
        
    }
    
    
    func configUI(){
        view.backgroundColor = UIColor(named: "bgColor2")
        view.addSubview(loginButton)
        view.addSubview(passwordTextField)
        view.addSubview(emailTextField)
        view.addSubview(signUpLabel)
        
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
            signUpLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
//            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
        
    }
}
