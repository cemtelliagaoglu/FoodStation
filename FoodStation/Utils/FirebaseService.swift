//
//  FirebaseService.swift
//  FoodStation
//
//  Created by admin on 20.02.2023.
//

import FirebaseDatabase
import FirebaseAuth

struct FirebaseService{
    
    static func requestUpdateFoodLike(foodID: String, didLike: Bool, completion: @escaping((Error?) -> ())){
        if let currentUID = Auth.auth().currentUser?.uid{
            if didLike{
                // add food into the user-like struct
                Database.database().reference().child("user-like").child(currentUID).updateChildValues([foodID: 1]){ error, ref in
                    completion(error)
                }
            }else{
                // remove food from the user-like struct
                Database.database().reference().child("user-like").child(currentUID).child(foodID).removeValue { error, ref in
                    completion(error)
                }
            }
        }
    }
    
    static func requestLoadLikedFoodList(completion: @escaping(([Food]?) -> ())){
        if let currentUID = Auth.auth().currentUser?.uid{
            // check FirebaseDatabase for liked foodIDs
            Database.database().reference().child("user-like").child(currentUID).observe(.value) { snapshot in
                // check foodList at APIService to find likedFoodData
                APIService.requestAllFoodsInDatabase { foods, error in
                    if error != nil{
                        print("Error while fetching from allFoodsInDatabase at APIService: \(error!)")
                        completion(nil)
                    }else{
                        // create temporary list for appending only liked foods
                        var tempList = [Food]()
                        guard let foodsInDatabase = foods else{
                            print("No food response from APIService")
                            return
                        }
                        for var food in foodsInDatabase{
                            if snapshot.hasChild(food.foodId){
                                food.didLike = true
                                tempList.append(food)
                            }
                        }
                        completion(tempList)
                    }
                }
            }
        }
        
    }
    
    static func addLikesToFoodList(for foodList: [Food], completion: @escaping(([Food]) -> ())){
        if let currentUID = Auth.auth().currentUser?.uid{
            Database.database().reference().child("user-like").child(currentUID).observe(.value) { snapshot in
                var tempList = [Food]()
                for var food in foodList{
                    if snapshot.hasChild(food.foodId){
                        food.didLike = true
                    }
                    tempList.append(food)
                }
                completion(tempList)
            }
        }
    }
    
    static func requestSignIn(withEmail: String, password: String, completion: @escaping((Error?) -> ())){
        Auth.auth().signIn(withEmail: withEmail, password: password){ (authResult, error) in
            completion(error)
        }
    }
    static func requestSignUp(email: String, password: String, completion: @escaping ((Error?) -> ())){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            completion(error)
        }
    }
    static func requestSignOut(completion: @escaping((Error?) -> ())){
        do{
            try Auth.auth().signOut()
            completion(nil)
        }catch{
            completion(error)
        }
    }
    static func checkLoginStatus(completion: @escaping((Bool) -> ())){
        let isLoggedIn = Auth.auth().currentUser != nil
        completion(isLoggedIn)
    }
    static func requestUserEmail(completion: @escaping((String?) -> ())){
        completion(Auth.auth().currentUser?.email)
    }
    static func requestUserUID(completion: @escaping((String?) -> ())){
        completion(Auth.auth().currentUser?.uid)
    }
}
