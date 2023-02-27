//
//  FoodCell.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit
import Kingfisher

protocol FoodCellDelegate{
    func foodAmountDidChange(indexPath: IndexPath, newValue: Int)
    func likeButtonTapped(indexPath: IndexPath ,didLike: Bool)
}

class FoodCell: UICollectionViewCell{
    //MARK: - Properties
    
    var delegate: FoodCellDelegate?
    
    var food: Food?{
        didSet{
            guard let food = food else{ return }
            nameLabel.text = food.foodName
            priceLabel.text = food.foodPrice + " TL"
            guard let imageURLString = food.foodImageURL else{ return }
            DispatchQueue.main.async {
                self.imageView.kf.setImage(with: URL(string: imageURLString)!)
            }
        }
    }
    
    var didLike: Bool = false{
        didSet{
            updateUI()
        }
    }
    
    var indexPath: IndexPath?
    
    var viewingMode: ViewingMode?{
        didSet{
            configUI()
        }
    }
    
    enum ViewingMode{
        case like, homepage
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
        stackView.alignment = .center
        stackView.contentMode = .scaleToFill
        stackView.distribution = .fill
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var customStepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.viewingMode = .vertical
        stepper.delegate = self
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    lazy var likeButton: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "heart")!)
        view.contentMode = .scaleAspectFit
        view.tintColor = UIColor(named: "bgColor1")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleLikeTapped))
        tapGesture.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGesture)
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Handlers
    @objc func handleLikeTapped(){
        guard let indexPath = indexPath else{
            print("index for cell not set")
            return
        }
        delegate?.likeButtonTapped(indexPath: indexPath, didLike: !didLike)
    }
    
    func configUI(){

        if viewingMode == .like{
            addSubview(mainStackView)
            addSubview(likeButton)
            
            mainStackView.axis = .horizontal
            mainStackView.spacing = 16
            bottomStackView.spacing = 8
            
            NSLayoutConstraint.activate([
                // mainStackView
                mainStackView.topAnchor.constraint(equalTo: topAnchor),
                mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                mainStackView.trailingAnchor.constraint(equalTo: likeButton.leadingAnchor, constant: -16),
                // likeButton
                likeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                likeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                likeButton.heightAnchor.constraint(equalToConstant: 30),
                likeButton.widthAnchor.constraint(equalToConstant: 35),
                // imageView
                imageView.heightAnchor.constraint(equalToConstant: 100),
                imageView.widthAnchor.constraint(equalToConstant: 100)
            ])
            
        }else{
            addSubview(mainStackView)
            addSubview(customStepper)
            addSubview(likeButton)
            
            mainStackView.axis = .vertical
            
            NSLayoutConstraint.activate([
                // mainStackView
                mainStackView.topAnchor.constraint(equalTo: topAnchor),
                mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
                mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
                mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
                // bottomStackView
                bottomStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor,constant: 8),
                bottomStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -8),
                // customStepper
                customStepper.topAnchor.constraint(equalTo: topAnchor),
                customStepper.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                // likeButton
                likeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                likeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
                likeButton.heightAnchor.constraint(equalToConstant: 30),
                likeButton.widthAnchor.constraint(equalToConstant: 35)
            ])
            layer.borderWidth = 0.5
            layer.cornerRadius = 10
            layer.borderColor = UIColor(named: "bgColor1")!.cgColor
        }
        
    }
    
    func updateUI(){
        let image = didLike ? UIImage(systemName: "heart.fill"):UIImage(systemName: "heart")
        likeButton.image = image
    }
}
//MARK: - CustomStepper Delegate
extension FoodCell: CustomStepperDelegate{
    func countDidChange(newValue: Int) {
        guard let indexPath = indexPath else{
            print("index for cell not set")
            return
        }
        delegate?.foodAmountDidChange(indexPath: indexPath, newValue: newValue)
    }
}
