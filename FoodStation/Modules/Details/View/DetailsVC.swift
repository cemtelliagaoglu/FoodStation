//
//  DetailsVC.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit

class DetailsVC: UIViewController{
    //MARK: - Properties
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let foodNameLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
