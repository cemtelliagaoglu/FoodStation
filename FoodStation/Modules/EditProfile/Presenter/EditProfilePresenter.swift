//
//  EditProfilePresenter.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

class EditProfilePresenter: EditProfileViewToPresenter{
    var interactor: EditProfilePresenterToInteractor?
    var view: EditProfilePresenterToView?
    var router: EditProfilePresenterToRouter?
    
    func notifyViewDidLoad() {
        view?.configUI()
    }
    func notifyViewWillAppear() {
        interactor?.requestLoadUserInfo()
    }
    
    func saveChangesTapped(name: String, address: String, cardNumber: String) {
        interactor?.requestUpdateUserInfo(name: name, address: address, cardNumber: cardNumber)
    }
}
//MARK: - InteractorToPresenter
extension EditProfilePresenter: EditProfileInteractorToPresenter{
    
    func userInfoLoadedSuccessfully(name: String, address: String, cardNumber: String) {
        view?.setUserInfo(name: name, address: address, cardNumber: cardNumber)
    }
    func updatedUserInfoSuccessfully() {
        router?.popVC()
    }
    func requestFailed(with errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
}
