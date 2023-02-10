//
//  LoginPresenter.swift
//  FoodStation
//
//  Created by admin on 7.02.2023.
//

import UIKit

class LoginPresenter: LoginViewToPresenter{
    
    var interactor: LoginPresenterToInteractor?
    var router: LoginPresenterToRouter?
    var view: LoginPresenterToView?
    
    func loginTapped(with email: String, _ password: String) {
        interactor?.requestAuthentication(with: email, password)
    }
    
    func signUpTapped() {
        router?.goToSignUpVC()
    }
    func notifyViewDidLoad() {
        view?.configUI()
    }
}

//MARK: - InteractorToPresenter
extension LoginPresenter: LoginInteractorToPresenter{
    
    func authenticationSucceed() {
        router?.goToMainTabVC()
    }
    
    func authenticationFailed(with error: Error) {
        view?.showAuthenticationError(error)
    }
    
}
