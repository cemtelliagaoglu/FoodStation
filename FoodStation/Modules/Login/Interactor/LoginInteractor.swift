//
//  LoginInteractor.swift
//  FoodStation
//
//  Created by admin on 7.02.2023.
//

import UIKit
import FirebaseAuth

class LoginInteractor: LoginPresenterToInteractor{
    
    var presenter: LoginInteractorToPresenter?
    
    func requestAuthentication(with email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil{
                self.presenter?.authenticationFailed(with: error!)
            }else{
                self.presenter?.authenticationSucceed()
            }
        }
    }
}
