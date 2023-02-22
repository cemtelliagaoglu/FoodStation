//
//  LoginInteractor.swift
//  FoodStation
//
//  Created by admin on 7.02.2023.
//

class LoginInteractor: LoginPresenterToInteractor{
    
    var presenter: LoginInteractorToPresenter?
    
    func requestAuthentication(with email: String, _ password: String) {
        FirebaseService.requestSignIn(withEmail: email, password: password) { error in
            if error != nil{
                self.presenter?.authenticationFailed(with: error!)
            }else{
                self.presenter?.authenticationSucceed()
            }
        }
    }
}
