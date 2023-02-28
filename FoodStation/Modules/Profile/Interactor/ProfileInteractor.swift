//
//  ProfileInteractor.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

class ProfileInteractor: ProfilePresenterToInteractor{
    var presenter: ProfileInteractorToPresenter?
    
    func requestLogOut() {
        FirebaseService.requestSignOut { error in
            if error != nil{
                self.presenter?.requestFailed(with: error!.localizedDescription)
            }else{
                self.presenter?.loggedOutSuccessfully()
            }
        }
    }
}


