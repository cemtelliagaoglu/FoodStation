//
//  SignUpInteractor.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

class SignUpInteractor: SignUpPresenterToInteractor{
    
    var presenter: SignUpInteractorToPresenter?
    
    func requestSignUp(with email: String, _ password: String, _ name: String) {
        FirebaseService.requestSignUp(email: email, password: password) { error in
            if error != nil{
                self.presenter?.requestSignUpFailed(with: error!)
            }else{
                self.presenter?.requestSignUpSucceed()
            }
        }
    }
    
}
