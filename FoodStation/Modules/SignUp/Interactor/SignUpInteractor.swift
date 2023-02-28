//
//  SignUpInteractor.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

class SignUpInteractor: SignUpPresenterToInteractor{
    
    var presenter: SignUpInteractorToPresenter?
    
    func requestSignUp(with email: String, _ password: String, _ name: String, address: String) {
        FirebaseService.requestSignUp(email: email, password: password) { uid, error in
            if error != nil{
                self.presenter?.requestSignUpFailed(with: error!)
            }else if uid != nil{
                FirebaseService.createNewUserInfo(uid: uid!, name: name, address: address)
                self.presenter?.requestSignUpSucceed()
            }
        }
    }
    
}
