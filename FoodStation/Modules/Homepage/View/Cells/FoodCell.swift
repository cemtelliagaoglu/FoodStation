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
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Medium", size: 16)
        label.textColor = .black

        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 16)
        label.textColor = .black
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bottomStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        stackView.axis = .vertical
//        stackView.contentMode = .scaleToFill
        stackView.backgroundColor = .white
        stackView.distribution = .fill
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imageView, bottomStackView])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .white
        stackView.contentMode = .scaleToFill
        stackView.distribution = .fill
        bottomStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor,constant: 8).isActive = true
        bottomStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -8).isActive = true
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let customStepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.viewingMode = .vertical
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
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
        
        addSubview(mainStackView)
        addSubview(customStepper)
        
        NSLayoutConstraint.activate([
            // mainStackView
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            // customStepper
            customStepper.topAnchor.constraint(equalTo: topAnchor),
            customStepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            customStepper.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            customStepper.widthAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    @objc func handleAddButtonTapped(){
        print("Add Button Tapped")
    }
    
}
