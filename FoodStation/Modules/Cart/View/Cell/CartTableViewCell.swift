//
//  CartTableViewCell.swift
//  FoodStation
//
//  Created by admin on 14.02.2023.
//

import UIKit

protocol CartTableViewCellDelegate{
    func foodCountDidChange( at indexPath: IndexPath, newValue: Int)
}

class CartTableViewCell: UITableViewCell{
    //MARK: - Properties
    
    var delegate: CartTableViewCellDelegate?
    
    var indexPath: IndexPath?
    
    lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Medium", size: 18)
        label.textColor = .black
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 18)
        label.textColor = .black
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, priceLabel])
        stackView.axis = .vertical
//        stackView.contentMode = .scaleToFill
        stackView.backgroundColor = .clear
        stackView.distribution = .fill
        stackView.layer.cornerRadius = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let customStepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Handler
    func configUI(){
        customStepper.delegate = self
        contentView.isUserInteractionEnabled = true
        selectionStyle = .none
        addSubview(foodImageView)
        addSubview(verticalStackView)
        addSubview(customStepper)
        
        NSLayoutConstraint.activate([
            // foodImageView
            foodImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            foodImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            foodImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            foodImageView.widthAnchor.constraint(equalToConstant: 100),
            // verticalStackView
            verticalStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: 16),
            // customStepper
            customStepper.centerYAnchor.constraint(equalTo: centerYAnchor),
            customStepper.leadingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: 8),
            customStepper.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            customStepper.widthAnchor.constraint(equalToConstant: 100),
            customStepper.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
//MARK: - CustomStepperDelegate
extension CartTableViewCell: CustomStepperDelegate{
    func countDidChange(newValue: Int) {
        if let indexPath = indexPath{
            delegate?.foodCountDidChange(at: indexPath, newValue: newValue)
        }
    }
}
