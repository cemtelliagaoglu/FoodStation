//
//  OrderHistoryProtocols.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

protocol OrderHistoryViewToPresenter{
    var interactor: OrderHistoryPresenterToInteractor? { get set }
    var view: OrderHistoryPresenterToView? { get set }
    var router: OrderHistoryPresenterToRouter? { get set }
    
    func notifyViewDidLoad()
    func numberOfItems() -> Int?
    func orderForCell(at index: Int) -> Order?
    func backButtonTapped()
}

protocol OrderHistoryPresenterToInteractor{
    var presenter: OrderHistoryInteractorToPresenter? { get set}
    
    func requestLoadOrderHistory()
    func numberOfOrders() -> Int?
    func orderInfo(at index: Int) -> Order?
    
}
protocol OrderHistoryInteractorToPresenter{
    func loadedOrderHistorySuccessfully()
    func requestFailed(with errorMessage: String)
}

protocol OrderHistoryPresenterToView{
    func configUI()
    func reloadData()
    func showErrorMessage(_ errorMessage: String)
}

protocol OrderHistoryPresenterToRouter{
    static func createModule() -> OrderHistoryVC
    func popVC()
}
