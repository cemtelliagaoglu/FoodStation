//
//  SignUpPresenter.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

class SignUpPresenter: SignUpViewToPresenter{
    
    var interactor: SignUpPresenterToInteractor?
    var router: SignUpPresenterToRouter?
    var view: SignUpPresenterToView?
    
    func signUpTapped(with email: String, _ password: String, _ name: String) {
        interactor?.requestSignUp(with: email, password, name)
    }
    func loginTapped() {
        router?.popVC()
    }
    
    func notifyViewDidLoad() {
        view?.configUI()
    }
    
}
//MARK: - InteractorToPresenter
extension SignUpPresenter: SignUpInteractorToPresenter{
    
    func requestSignUpFailed(with error: Error) {
        view?.signUpFailed(with: error)
    }
    func requestSignUpSucceed() {
        router?.pushToMainTabVC()
    }
}
