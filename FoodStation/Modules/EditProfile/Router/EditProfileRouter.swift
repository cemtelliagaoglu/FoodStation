//
//  EditProfileRouter.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

class EditProfileRouter: EditProfilePresenterToRouter{
    
    var viewController: EditProfileVC?
    
    static func createModule() -> EditProfileVC {
        let view = EditProfileVC()
        
        let presenter = EditProfilePresenter()
        let router = EditProfileRouter()
        
        view.presenter = presenter
        presenter.view = view
        view.presenter?.interactor = EditProfileInteractor()
        view.presenter?.router = router
        view.presenter?.interactor?.presenter = presenter
        
        router.viewController = view
        
        return view
    }
    func popVC() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}
