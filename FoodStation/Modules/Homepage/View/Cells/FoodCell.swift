//
//  FoodCell.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit
import Kingfisher

class FoodCell: UICollectionViewCell{
    //MARK: - Properties
    
    var food: Food?{
        didSet{
            guard let food = food else{ return }
            nameLabel.text = food.foodName
            priceLabel.text = food.foodPrice + "₺"
            guard let imageURLString = food.foodImageURL else{ return }
            DispatchQueue.main.async {
                self.imageView.kf.setImage(with: URL(string: imageURLString)!)
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 14)
        label.textColor = .black

        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-LightItalic", size: 14)
        label.textColor = .black
        label.textAlignment = .right
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        stackView.axis = .horizontal
//        stackView.contentMode = .scaleToFill
        stackView.backgroundColor = .white
        stackView.distribution = .fill
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, horizontalStackView])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = UIColor(named: "bgColor2")
        stackView.contentMode = .scaleToFill
        stackView.distribution = .fill
        
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Handlers
    
    func configUI(){
        
        addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
        
    }
    
    @objc func handleAddButtonTapped(){
        print("Add Button Tapped")
    }
    
}
