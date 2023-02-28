//
//  ProfileRouter.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

class ProfileRouter: ProfilePresenterToRouter{
    
    var viewController: ProfileVC?
    
    static func createModule() -> ProfileVC {
        // module connection
        let view = ProfileVC()
        let presenter = ProfilePresenter()
        let router = ProfileRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = ProfileInteractor()
        presenter.router = router
        presenter.interactor?.presenter = presenter
        
        router.viewController = view
        
        return view
    }
    
    func pushToLoginVC() {
        let loginVC = LoginRouter.createModule()
        loginVC.modalPresentationStyle = .fullScreen
        viewController?.navigationController?.present(loginVC, animated: true)
    }
    func pushToEditProfileVC() {
        let editProfileVC = EditProfileRouter.createModule()
        viewController?.navigationController?.pushViewController(editProfileVC, animated: true)
    }
    func pushToOrderHistoryVC() {
        let orderHistoryVC = OrderHistoryRouter.createModule()
        
        viewController?.navigationController?.pushViewController(orderHistoryVC, animated: true)
    }
    func popVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
