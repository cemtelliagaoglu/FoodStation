//
//  SignUpProtocols.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

protocol SignUpViewToPresenter{
    var interactor: SignUpPresenterToInteractor? { get set }
    var router: SignUpPresenterToRouter?{ get set }
    
    func notifyViewDidLoad()
    func signUpTapped(with email: String, _ password: String, _ name: String, address: String)
    func loginTapped()
}

protocol SignUpPresenterToInteractor{
    var presenter: SignUpInteractorToPresenter? { get set }
    
    func requestSignUp(with email: String, _ password: String, _ name: String, address: String)
}

protocol SignUpInteractorToPresenter{
    var view: SignUpPresenterToView? { get set }
    
    func requestSignUpSucceed()
    func requestSignUpFailed(with error: Error)
}

protocol SignUpPresenterToView{
    func configUI()
    func signUpFailed(with error: Error)
}


protocol SignUpPresenterToRouter{
    static func createModule() -> SignUpVC
    func popVC()
    func pushToMainTabVC()
}
