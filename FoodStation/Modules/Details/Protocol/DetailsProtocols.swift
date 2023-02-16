//
//  DetailsProtocols.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

protocol DetailsViewToPresenter{
    var interactor: DetailsPresenterToInteractor? { get set }
    var router: DetailsPresenterToRouter? { get set }
    
    func notifyViewDidLoad()
    func notifyViewWillAppear(for food: Food)
    func foodDidSet(_ food: Food)
    func foodAmountDidChange(for food: Food, amount: Int)
}

protocol DetailsPresenterToInteractor{
    var presenter: DetailsInteractorToPresenter? { get set }
    
    func requestUpdateCart(food: Food, amount: Int)
    func requestFoodAmountInCart(for food: Food)
}

protocol DetailsInteractorToPresenter{
    var view: DetailsPresenterToView? { get set }

    func updatedCartSuccessfuly()
    func requestFailed(withErrorMessage message: String)
    func foodAmountInCart(_ amount: Int)
}

protocol DetailsPresenterToView{
    func configUI()
    func setFoodAmount(_ amount: Int)
    func showError(_ message: String)
    func startLoadingAnimation()
    func stopLoadingAnimation()
}


protocol DetailsPresenterToRouter{
    static func createModule() -> DetailsVC
    func popVC()
}
