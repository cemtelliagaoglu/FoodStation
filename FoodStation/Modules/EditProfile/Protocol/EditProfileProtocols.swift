//
//  EditProfileProtocols.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

protocol EditProfileViewToPresenter{
    var interactor: EditProfilePresenterToInteractor? { get set }
    var view: EditProfilePresenterToView? { get set }
    var router: EditProfilePresenterToRouter? { get set }
    
    func notifyViewDidLoad()
    func notifyViewWillAppear()
    func saveChangesTapped(name: String, address: String, cardNumber: String)
    func backButtonTapped()
}

protocol EditProfilePresenterToInteractor{
    var presenter: EditProfileInteractorToPresenter? { get set }
    
    func requestLoadUserInfo()
    func requestUpdateUserInfo(name: String, address: String, cardNumber: String)
}

protocol EditProfileInteractorToPresenter{
    func userInfoLoadedSuccessfully(name: String, address: String, cardNumber: String)
    func updatedUserInfoSuccessfully()
    func requestFailed(with errorMessage: String)
}

protocol EditProfilePresenterToView{
    func configUI()
    func setUserInfo(name: String, address: String, cardNumber: String)
    func showErrorMessage(_ errorMessage: String)
}

protocol EditProfilePresenterToRouter{
    static func createModule() -> EditProfileVC
    func popVC()
}
