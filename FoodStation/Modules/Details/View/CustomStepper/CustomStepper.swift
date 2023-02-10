//
//  AddToCartButton.swift
//  FoodStation
//
//  Created by admin on 8.02.2023.
//

import UIKit

protocol CustomStepperDelegate{
    func countDidChange(newValue: Int)
}

class CustomStepper: UIView{
    //MARK: - Properties
    var itemCount: Int = 0{
        didSet{
            leftButton.isHidden = itemCount == 0
            countLabel.text = String(itemCount)
            checkLeftButton()
        }
    }
    
    var delegate: CustomStepperDelegate?
    
    lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = itemCount > 1 ? UIImage(systemName: "minus"): UIImage(systemName: "trash")
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 10
        button.isHidden = itemCount == 0
        button.tintColor = UIColor(named: "bgColor2")
        button.backgroundColor = UIColor(named: "bgColor1")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLeftButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = String(itemCount)
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Medium", size: 25)
        label.textColor = UIColor(named: "bgColor1")
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = UIColor(named: "bgColor2")
        button.backgroundColor = UIColor(named: "bgColor1")
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRightButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftButton, countLabel, rightButton])
        stackView.axis = .horizontal
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        stackView.distribution = .fill
        stackView.alignment = .center
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
//        addSubview(stackView)
//
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//        ])
        addSubview(leftButton)
        addSubview(countLabel)
        addSubview(rightButton)
        
        NSLayoutConstraint.activate([
            // countLabel
            countLabel.topAnchor.constraint(equalTo: topAnchor),
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            // leftButton
            leftButton.topAnchor.constraint(equalTo: topAnchor),
            leftButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            leftButton.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor, constant: -4),
            leftButton.widthAnchor.constraint(equalToConstant: 40),
            // rightButton
            rightButton.topAnchor.constraint(equalTo: topAnchor),
            rightButton.leadingAnchor.constraint(equalTo: countLabel.trailingAnchor, constant: 4),
            rightButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            rightButton.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc func handleLeftButtonPressed(){
        itemCount -= 1
    }
    @objc func handleRightButtonPressed(){
        itemCount += 1
    }
    
    func checkLeftButton(){
        let image = itemCount > 1 ? UIImage(systemName: "minus"): UIImage(systemName: "trash")
        leftButton.setImage(image, for: .normal)
        leftButton.isHidden = itemCount == 0
    }
}
