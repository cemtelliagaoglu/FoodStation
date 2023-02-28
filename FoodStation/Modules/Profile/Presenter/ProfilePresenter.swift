//
//  ProfilePresenter.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

class ProfilePresenter: ProfileViewToPresenter{
    var interactor: ProfilePresenterToInteractor?
    var view: ProfilePresenterToView?
    var router: ProfilePresenterToRouter?
    
    func notifyViewDidLoad() {
        view?.configUI()
    }
    func notifyViewWillAppear() {
        view?.hideTabBar(isHidden: true)
    }
    func logOutTapped() {
        interactor?.requestLogOut()
    }
    func profileTapped() {
        router?.pushToEditProfileVC()
    }
    func orderHistoryTapped() {
        router?.pushToOrderHistoryVC()
    }
    func backButtonTapped() {
        router?.popVC()
        view?.hideTabBar(isHidden: false)
    }
}

//MARK: - InteractorToPresenter Methods
extension ProfilePresenter: ProfileInteractorToPresenter{
    
    func loggedOutSuccessfully() {
        router?.pushToLoginVC()
        router?.popVC()
        view?.hideTabBar(isHidden: false)
    }
    func requestFailed(with errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
}
