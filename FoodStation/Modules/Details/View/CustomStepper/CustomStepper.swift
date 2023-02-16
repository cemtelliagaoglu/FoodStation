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
        button.tintColor = UIColor(named: "bgColor2")
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
        button.tintColor = UIColor(named: "bgColor2")
        button.backgroundColor = UIColor(named: "bgColor1")
        button.contentMode = .scaleAspectFit
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRightButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [decrementButton, countLabel, incrementButton])
        stackView.axis = .horizontal
        updateUI()
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [decrementButton, countLabel, incrementButton])
        stackView.axis = .vertical
        updateUI()
        stackView.layer.cornerRadius = 8
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.color = UIColor(named: "bgColor1")
        return spinner
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
        addSubview(spinner)
        if viewingMode == .vertical{
            addSubview(verticalStackView)
            NSLayoutConstraint.activate([
                verticalStackView.topAnchor.constraint(equalTo: topAnchor),
                verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                decrementButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor),
                incrementButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor),
                incrementButton.heightAnchor.constraint(equalTo: verticalStackView.heightAnchor, multiplier: 0.33),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])

        }else{
            addSubview(stackView)
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: topAnchor),
                stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                decrementButton.heightAnchor.constraint(equalTo: stackView.heightAnchor),
                incrementButton.heightAnchor.constraint(equalTo: stackView.heightAnchor),
                spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
                spinner.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }
        
    }
    func updateUI(){
        
        let image = itemCount > 1 ? UIImage(systemName: "minus"): UIImage(systemName: "trash")
        decrementButton.setImage(image, for: .normal)
        if viewingMode == .vertical{
            incrementButton.setTitle(nil, for: .normal)
            incrementButton.setImage(UIImage(systemName: "plus"), for: .normal)
            let isHidden = itemCount > 0
            decrementButton.isHidden = !isHidden
            countLabel.isHidden = !isHidden
        }else{
            if itemCount == 0{
                decrementButton.isHidden = true
                countLabel.isHidden = true
                incrementButton.setTitle("Add To Cart", for: .normal)
                incrementButton.setImage(nil, for: .normal)
            }else{
                decrementButton.isHidden = false
                countLabel.isHidden = false
                incrementButton.setTitle("", for: .normal)
                incrementButton.setImage(UIImage(systemName: "plus"), for: .normal)
            }
        }
    }
    func startLoadingAnimation(){
        incrementButton.isUserInteractionEnabled = false
        decrementButton.isUserInteractionEnabled = false
        spinner.startAnimating()
    }
    func stopLoadingAnimation(){
        incrementButton.isUserInteractionEnabled = true
        decrementButton.isUserInteractionEnabled = true
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
