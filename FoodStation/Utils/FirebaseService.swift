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
            Database.database().reference().child("user-like").child(currentUID).observeSingleEvent(of: .value) { snapshot in
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
    static func requestSignUp(email: String, password: String, completion: @escaping ((String?, Error?) -> ())){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            let uid = authResult?.user.uid
            completion(uid, error)
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
    static func createNewUserInfo(uid: String, name: String, address: String, card_number: String){
        
        let dictionary = ["name": name, "address": address, "card_number": card_number]
        Database.database().reference().child("user-info").child(uid).setValue(dictionary)
    }
    static func requestLoadUserInfo(completion: @escaping(([String:AnyObject]) -> ())){
        if let currentUID = Auth.auth().currentUser?.uid{
            // user-info --> name, address, card number
            Database.database().reference().child("user-info").child(currentUID).observe(.value) { snapshot in
                guard let dictionary = snapshot.value as? Dictionary<String,AnyObject> else{ return }
                completion(dictionary)
            }
        }
    }
    static func requestUpdateUserAddress(newAddress: String){
        if let currentUID = Auth.auth().currentUser?.uid{
            // user-info --> name, address, card number
            Database.database().reference().child("user-info").child(currentUID).updateChildValues(["address": newAddress])
        }
    }
    static func requestUpdateUserName(newName: String){
        if let currentUID = Auth.auth().currentUser?.uid{
            // user-info --> name, address, card number
            Database.database().reference().child("user-info").child(currentUID).updateChildValues(["name": newName])
        }
    }
    static func requestUpdateUserCreditCard(newCardNumber: String){
        if let currentUID = Auth.auth().currentUser?.uid{
            Database.database().reference().child("user-info").child(currentUID).updateChildValues(["card_number": newCardNumber])
        }
    }
    static func requestSaveOrder(cart: [FoodInCart], price: Int, address: String, cardNumber: String,date: String, completion: @escaping((Error?) -> ()) ){
        // order-history -> uid -> order-id -> address: "" , details: [FoodName,FoodAmount, FoodPrice, FoodImageURL],
        if let currentUID = Auth.auth().currentUser?.uid{
            let orderRef = Database.database().reference().child("order-history").child(currentUID).childByAutoId()
            
            var detailsArray: [String: AnyObject] = [:]
            for index in 0..<cart.count{
                let food = cart[index]
                let foodDetails: [String: String] = ["food_name": food.foodName,
                                                     "food_price": food.foodPrice,
                                                     "food_amount": food.foodAmount,
                                                     "food_image_name": food.foodImageName
                                                    ]
                detailsArray["food\(index)"] = foodDetails as AnyObject
            }
            
            let dictionary: [String: Any] = ["date": date,"address": address, "price": price, "card_number": cardNumber,"details": detailsArray]
            orderRef.setValue(dictionary) { error, ref in
               completion(error)
            }
        }
    }
    static func requestOrderHistory(){
        if let currentUID = Auth.auth().currentUser?.uid{
            
        }
    }
}
