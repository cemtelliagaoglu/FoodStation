//
//  EditProfileInteractor.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

class EditProfileInteractor: EditProfilePresenterToInteractor{
    
    var presenter: EditProfileInteractorToPresenter?
    
    func requestLoadUserInfo() {
        FirebaseService.requestLoadUserInfo { userInfo in
            guard let name = userInfo["name"] as? String else{ return }
            guard let address = userInfo["address"] as? String else{ return }
            guard let cardNumber = userInfo["card_number"] as? String else{ return }
            self.presenter?.userInfoLoadedSuccessfully(name: name, address: address, cardNumber: cardNumber)
        }
    }
    func requestUpdateUserInfo(name: String, address: String, cardNumber: String) {
        FirebaseService.requestUpdateUserInfo(name: name, address: address, cardNumber: cardNumber) { error in
            if error != nil{
                self.presenter?.requestFailed(with: error!.localizedDescription)
            }else{
                self.presenter?.updatedUserInfoSuccessfully()
            }
        }
    }
}
