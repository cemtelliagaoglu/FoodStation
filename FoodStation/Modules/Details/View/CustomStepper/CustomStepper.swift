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
            countLabel.text = String(itemCount)
            updateUI()
        }
    }
    
    var delegate: CustomStepperDelegate?
    
    var viewingMode: ViewingMode?{
        didSet{
            configUI()
            updateUI()
        }
    }
    
    enum ViewingMode{
        case vertical, horizontal
    }
    
    lazy var decrementButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = itemCount > 1 ? UIImage(systemName: "minus"): UIImage(systemName: "trash")
        button.setImage(image, for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "bgColor1")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLeftButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.font = UIFont(name: "OpenSans-Medium", size: 25)
        label.textColor = UIColor(named: "bgColor1")
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var incrementButton: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.cornerRadius = 10
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(named: "bgColor1")
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRightButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [decrementButton, midContainerStackView, incrementButton])
        stackView.axis = .horizontal
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var midContainerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countLabel, spinner])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.isHidden = true
        spinner.color = UIColor(named: "bgColor1")
        return spinner
    }()

    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
//        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - Handlers
    func configUI(){
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
        ])
        if viewingMode == .vertical{
            NSLayoutConstraint.activate([
                incrementButton.widthAnchor.constraint(equalToConstant: 40),
                incrementButton.heightAnchor.constraint(equalToConstant: 40),
                decrementButton.widthAnchor.constraint(equalToConstant: 40),
                decrementButton.heightAnchor.constraint(equalToConstant: 40),
            ])
        }else{
            NSLayoutConstraint.activate([
                decrementButton.heightAnchor.constraint(equalTo: stackView.heightAnchor),
                incrementButton.heightAnchor.constraint(equalTo: stackView.heightAnchor),
            ])
        }
    }

    func updateUI(){
        
        let image = itemCount > 1 ? UIImage(systemName: "minus"): UIImage(systemName: "trash")
        decrementButton.setImage(image, for: .normal)
        if viewingMode == .vertical{
            stackView.axis = .vertical
            midContainerStackView.axis = .horizontal
            incrementButton.setTitle(nil, for: .normal)
            incrementButton.setImage(UIImage(systemName: "plus"), for: .normal)
            let hasItem = itemCount > 0
            decrementButton.isHidden = !hasItem
            midContainerStackView.isHidden = !hasItem
        }else{
            stackView.axis = .horizontal
            midContainerStackView.axis = .vertical
            let hasItem = itemCount > 0
            decrementButton.isHidden = !hasItem
            midContainerStackView.isHidden = !hasItem
            if itemCount == 0{
                incrementButton.setTitle("Add To Cart", for: .normal)
                incrementButton.setImage(nil, for: .normal)
            }else{
                incrementButton.setTitle("", for: .normal)
                incrementButton.setImage(UIImage(systemName: "plus"), for: .normal)
            }
        }
    }
    func startLoadingAnimation(){
        incrementButton.isUserInteractionEnabled = false
        decrementButton.isUserInteractionEnabled = false
        countLabel.isHidden = true
        spinner.isHidden = false
        spinner.startAnimating()
    }
    func stopLoadingAnimation(){
        incrementButton.isUserInteractionEnabled = true
        decrementButton.isUserInteractionEnabled = true
        countLabel.isHidden = false
        spinner.isHidden = true
        spinner.stopAnimating()
    }
    @objc func handleLeftButtonPressed(){
        itemCount -= 1
        delegate?.countDidChange(newValue: itemCount)
    }
    @objc func handleRightButtonPressed(){
        itemCount += 1
        delegate?.countDidChange(newValue: itemCount)
    }
}
