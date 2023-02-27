//
//  OrderHistoryPresenter.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

class OrderHistoryPresenter: OrderHistoryViewToPresenter{
    var interactor: OrderHistoryPresenterToInteractor?
    
    var view: OrderHistoryPresenterToView?
    
    var router: OrderHistoryPresenterToRouter?
    
    func notifyViewDidLoad() {
        view?.configUI()
        interactor?.requestLoadOrderHistory()
    }
    
    func numberOfItems() -> Int? {
        return interactor?.numberOfOrders()
    }
    
    func orderForCell(at index: Int) -> Order? {
        return interactor?.orderInfo(at: index)
    }
    
}
//MARK: - InteractorToPresenter
extension OrderHistoryPresenter: OrderHistoryInteractorToPresenter{
    func loadedOrderHistorySuccessfully() {
        view?.reloadData()
    }
    
    func requestFailed(with errorMessage: String) {
        view?.showErrorMessage(errorMessage)
    }
}
