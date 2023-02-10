//
//  SignUpInteractor.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

import UIKit
import FirebaseAuth

class SignUpInteractor: SignUpPresenterToInteractor{
    
    var presenter: SignUpInteractorToPresenter?
    
    func requestSignUp(with email: String, _ password: String, _ name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if error != nil{
                print(error!.localizedDescription)
                self.presenter?.requestSignUpFailed(with: error!)
            }else{
                self.presenter?.requestSignUpSucceed()
            }
        }
        
    }
    
}
