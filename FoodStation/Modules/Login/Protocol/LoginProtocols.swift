//
//  LoginProtocols.swift
//  FoodStation
//
//  Created by admin on 7.02.2023.
//

import UIKit

protocol LoginViewToPresenter{
    var interactor: LoginPresenterToInteractor? { get set }
    var router: LoginPresenterToRouter? { get set }
    
    func notifyViewDidLoad()
    func loginTapped(with email: String, _ password: String)
    func signUpTapped()
}

protocol LoginPresenterToInteractor{
    var presenter: LoginInteractorToPresenter? { get set }
    
    func requestAuthentication(with email: String,_ password: String)
}

protocol LoginInteractorToPresenter{
    var view: LoginPresenterToView? { get set } 
    
    func authenticationSucceed()
    func authenticationFailed(with error: Error)
}
protocol LoginPresenterToView{
    func configUI()
    func showAuthenticationError(_ error: Error)
}

protocol LoginPresenterToRouter{
    static func createModule() -> UINavigationController
    func goToSignUpVC()
    func goToMainTabVC()
}
