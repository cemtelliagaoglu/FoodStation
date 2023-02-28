//
//  ProfileProtocols.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

protocol ProfileViewToPresenter{
    var interactor: ProfilePresenterToInteractor? { get set }
    var view: ProfilePresenterToView? { get set }
    var router: ProfilePresenterToRouter? { get set }
    
    func notifyViewDidLoad()
    func notifyViewWillAppear()
    func logOutTapped()
    func profileTapped()
    func orderHistoryTapped()
    func backButtonTapped()
}

protocol ProfilePresenterToInteractor{
    var presenter: ProfileInteractorToPresenter? { get set }
    func requestLogOut()
}

protocol ProfileInteractorToPresenter{
    func loggedOutSuccessfully()
    func requestFailed(with errorMessage: String)
}

protocol ProfilePresenterToView{
    func configUI()
    func hideTabBar(isHidden: Bool)
    func reloadData()
    func showErrorMessage(_ errorMessage: String)
}

protocol ProfilePresenterToRouter{
    static func createModule() -> ProfileVC
    func pushToLoginVC()
    func pushToEditProfileVC()
    func pushToOrderHistoryVC()
    func popVC()
}
