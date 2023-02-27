//
//  Collection+Extension.swift
//  FoodStation
//
//  Created by admin on 26.02.2023.
//

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
