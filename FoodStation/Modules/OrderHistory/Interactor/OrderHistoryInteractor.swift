//
//  OrderHistoryInteractor.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

class OrderHistoryInteractor: OrderHistoryPresenterToInteractor{
    
    var orders: [Order]?
    
    var presenter: OrderHistoryInteractorToPresenter?
    
    func requestLoadOrderHistory() {
        FirebaseService.requestOrderHistory { orders in
            self.orders = orders.sorted(by: { $0.date > $1.date})
            self.presenter?.loadedOrderHistorySuccessfully()
        }
    }
    
    func numberOfOrders() -> Int? {
        return orders?.count
    }
    
    func orderInfo(at index: Int) -> Order? {
        return self.orders?[index]
    }
    
}
