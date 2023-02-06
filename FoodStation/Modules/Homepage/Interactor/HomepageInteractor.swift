//
//  HomepageInteractor.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import Alamofire
import Kingfisher
import UIKit


class HomepageInteractor: HomepagePresenterToInteractor{
    var presenter: HomepageInteractorToPresenter?
    
    private let imagesBaseURLString = "http://kasimadalan.pe.hu/yemekler/resimler/"
    private let allFoodsURLString = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php"
    
    let imageDownloader = ImageDownloader.default
    
    func loadData() {
        // get food data
        AF.request(allFoodsURLString,method: .get).response{ response in
            if let data = response.data{
                do{
                    let decodedData = try JSONDecoder().decode(FoodResponse.self, from: data)
                    var foods = [Food]()
                    // download food images
                    for var food in decodedData.foods{
                        food.foodImageURL = self.imagesBaseURLString + food.foodImageName
                        foods.append(food)
                    }
                    
                    self.presenter?.sendFetchedData(foods)
                }catch{
                    print(error)
                }
            }
        }
        
    }
    
}


