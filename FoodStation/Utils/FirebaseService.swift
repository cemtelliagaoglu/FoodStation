//
//  FirebaseService.swift
//  FoodStation
//
//  Created by admin on 20.02.2023.
//

import FirebaseDatabase

struct FirebaseService{
    
    static func requestUpdateFoodLike(for uid: String, foodID: String, didLike: Bool, completion: @escaping((Error?) -> ())){
            
        if didLike{
            // add food into the user-like struct
            Database.database().reference().child("user-like").child(uid).updateChildValues([foodID: 1]){ error, ref in
                completion(error)
            }
        }else{
            // remove food from the user-like struct
            Database.database().reference().child("user-like").child(uid).child(foodID).removeValue { error, ref in
                completion(error)
            }
        }
    }
    
}
