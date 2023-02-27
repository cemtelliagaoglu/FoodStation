//
//  OrderCell.swift
//  FoodStation
//
//  Created by admin on 27.02.2023.
//

import UIKit

class OrderCell: UICollectionViewCell{
    //MARK: - Properties
    
    var order: Order?{
        didSet{
            orderDidSet()
        }
    }
    lazy var orderInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 16)
        label.textColor = .black
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Medium", size: 16)
        label.textColor = .black
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-SemiBold", size: 16)
        label.textColor = UIColor(named: "bgColor1")
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "OpenSans-Regular", size: 20)
        label.textColor = .black
        label.numberOfLines = 1
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var topContainerView: UIView = {
        let view = UIView()
        view.addSubview(dateLabel)
        view.addSubview(addressLabel)
        view.addSubview(orderInfoLabel)
        
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: view.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            addressLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            addressLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            addressLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8),
            orderInfoLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 8),
            orderInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            orderInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            orderInfoLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -8)
        ])
        
        view.layer.cornerRadius = 10
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    lazy var stackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [topContainerView])
//        stackView.backgroundColor = .white
//        stackView.axis = .vertical
//        stackView.spacing = 4
////        stackView.alignment = .top
//        stackView.distribution = .fill
//        stackView.layer.cornerRadius = 10
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Handler
    func configUI(){
//        addSubview(stackView)
        addSubview(topContainerView)
        addSubview(priceLabel)
        
        NSLayoutConstraint.activate([
            // stackView
//            stackView.topAnchor.constraint(equalTo: topAnchor),
//            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
//            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
//            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            topContainerView.topAnchor.constraint(equalTo: topAnchor),
            topContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topContainerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            topContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            // priceLabel
            priceLabel.centerYAnchor.constraint(equalTo: topContainerView.centerYAnchor),
            priceLabel.leadingAnchor.constraint(equalTo: topContainerView.trailingAnchor, constant: 8)
        ])
    }
    func orderDidSet(){
        guard let order = order else { return }
        // set addressLabel
        addressLabel.text = order.address
        // set priceLabel
        priceLabel.text = "\(order.price) TL"
        // set dateLabel
        let date = Date(timeIntervalSince1970: TimeInterval(order.date)!)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        let dateString = formatter.string(from: date)
        dateLabel.text = dateString
        // order details
        var tempText = ""
        
        for (key, value) in order.details{
            // key -> FoodIDInOrder
            // value -> Food
            guard let foodName = value["food_name"] else{ return }
            guard let foodAmount = value["food_amount"] else{ return }
            tempText.append("\(foodName) (\(foodAmount)), ")
        }
        let detailsText = String(tempText.dropLast(2))
        orderInfoLabel.text = detailsText
    }
}
