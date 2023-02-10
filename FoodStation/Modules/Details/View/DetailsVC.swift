//
//  DetailsVC.swift
//  FoodStation
//
//  Created by admin on 6.02.2023.
//

import UIKit
import Kingfisher
import Alamofire

class DetailsVC: UIViewController{
    //MARK: - Properties
    
    var presenter: DetailsViewToPresenter?
    
    var food: Food?{
        didSet{
            guard let food = food else { return }
            imageView.kf.setImage(with: URL(string: food.foodImageURL!))
            foodNameLabel.text = food.foodName
            priceLabel.text = food.foodPrice + " ₺"
            presenter?.foodDidSet(food)
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let foodNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "OpenSans-SemiBold", size: 25)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "OpenSans-Medium", size: 20)!
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addToCartButton: UIButton = {
        let button = UIButton(type: .custom)
        let attributedTitle = NSAttributedString(string: "Add To Cart", attributes: [ .font: UIFont(name: "OpenSans-SemiBold", size: 25)!, .foregroundColor: UIColor(named: "bgColor2")!])
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.backgroundColor = UIColor(named: "bgColor1")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAddToCartButtonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var customStepper: CustomStepper = {
        let button = CustomStepper()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
        
    }
    
    //MARK: - Handlers
    @objc func handleAddToCartButtonPressed(){
        guard let food = self.food else{ return }
        presenter?.addToCartTapped(for: food, amount: customStepper.itemCount)
    }
    
    func addToCart(for username: String,_ food: Food, amount: Int){
        let baseURL = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
        
        print("FoodName: \(food.foodName) - FoodImageName: \(food.foodImageName) - FoodPrice: \(food.foodPrice)")
        let foodPrice = Int(food.foodPrice)!
        
        let params: [String: Any] = ["yemek_adi":food.foodName,"yemek_resim_adi":food.foodImageName, "yemek_fiyat": foodPrice,"yemek_siparis_adet": amount,"kullanici_adi": username]
        
        AF.request(URL(string: baseURL)!,method: .post, parameters: params).response(){ response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(CartResponse.self, from: data)
                    print("Adding to Cart Status: \(response.success == 1 ? "Successfull" : "Failed")")
                    
                }catch{
                    print(error)
                }
            }
        }
    }
    
    
    func loadCart(for username: String){
        // load Cart
        let baseURL = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
        
        let params = ["kullanici_adi": username]
        AF.request(URL(string: baseURL)!,method: .post, parameters: params).response(){ response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(CartResponse.self, from: data)
                    
                    print("Success: \(response.success)")
                    print("Sepet ID: \(response.cart![0].foodIDInCart) - Kullanici Adi: \(response.cart![0].username)")
                    
                }catch{
                    print(error)
                }
            }
        }
    }
    
    func deleteItem(){
        let baseURL = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php"
        let sepet_id = 83219
        // sepeti sil
        let params1: [String:Any] = ["kullanici_adi": "deneme", "sepet_yemek_id": sepet_id]
        AF.request(URL(string: baseURL)!,method: .post, parameters: params1).response(){ response in
            if let data = response.data{
                do{
                    let response = try JSONDecoder().decode(CartResponse.self, from: data)
                    print("Success: \(response.success == 1 ? "Success": "Failed")")
                    
                }catch{
                    print(error)
                }
            }
        }
    }
    
    
    
}
//MARK: - PresenterToView Methods
extension DetailsVC: DetailsPresenterToView{
    func configUI() {
        
        view.backgroundColor = UIColor(named: "bgColor2")
        view.addSubview(addToCartButton)
        view.addSubview(imageView)
        view.addSubview(foodNameLabel)
        view.addSubview(priceLabel)
        view.addSubview(customStepper)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            // addToCartButton
            addToCartButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16),
            addToCartButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            addToCartButton.widthAnchor.constraint(equalToConstant: 200),
            // imageView
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 32),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            // foodNameLabel
            foodNameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            foodNameLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            foodNameLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            // priceLabel
            priceLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor,constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16),
            priceLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16),
            
            // customStepper
            customStepper.topAnchor.constraint(equalTo: priceLabel.bottomAnchor,constant: 50),
            customStepper.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            customStepper.heightAnchor.constraint(equalToConstant: 50),
            customStepper.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    func updateView(with food: Food) {
        
    }
    func setFoodAmount(_ amount: Int) {
        self.customStepper.itemCount = amount
    }
    func showError(_ message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        navigationController?.present(alert, animated: true)
    }
    
}
//MARK: - CustomStepperDelegate
extension DetailsVC: CustomStepperDelegate{
    func countDidChange(newValue: Int) {
        if newValue > 0{
            // create a new cart with new value and delete old one
            
        }else{
            // delete item from cart
            
        }
    }
}
