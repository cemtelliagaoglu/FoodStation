//
//  ProfileVC.swift
//  FoodStation
//
//  Created by admin on 9.02.2023.
//

import UIKit

class ProfileVC: UIViewController{
    //MARK: - Properties
    
    var presenter: ProfileViewToPresenter?
    
    private let cellIdentifier = "cellIdentifier"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.notifyViewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.notifyViewWillAppear()
    }
    //MARK: - Handlers
    
    func handleLogOutTapped(){
        
        // declare alert controller
        let alertController = UIAlertController(title: "Are you sure to log out?", message: nil, preferredStyle: .alert)
        // add alert action
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { _ in
            self.presenter?.logOutTapped()
        }))
            
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alertController,animated: true)
    }
    func handleProfileTapped(){
        presenter?.profileTapped()
    }
    func handleOrderHistoryTapped(){
        presenter?.orderHistoryTapped()
    }
    @objc func handleBackButtonTapped(){
        presenter?.backButtonTapped()
    }
}
//MARK: - UITableView

extension ProfileVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Edit"
        }else if section == 1{
            return "Orders"
        }else{
            return "System"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.tintColor = UIColor(named: "bgColor1")
        cell.textLabel?.font = UIFont(name: "OpenSans-Regular", size: 18)
        if indexPath.section == 0{
            let image = UIImage(systemName: "person.fill")
            cell.textLabel?.text = "Profile"
            cell.imageView?.image = image
        }else if indexPath.section == 1{
            let image = UIImage(systemName: "clock.fill")
            cell.textLabel?.text = "Order History"
            cell.imageView?.image = image
        }else{
            cell.textLabel?.text = "Log Out"
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Log Out
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.textLabel?.text == "Log Out"{
            handleLogOutTapped()
        }else if cell?.textLabel?.text == "Profile"{
            handleProfileTapped()
        }else{
            handleOrderHistoryTapped()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
//MARK: - PresenterToView Methods
extension ProfileVC: ProfilePresenterToView{
    
    func configUI() {
        
        view.backgroundColor = UIColor(named: "bgColor2")
        navigationItem.title = "Profile"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(handleBackButtonTapped))
        view.addSubview(tableView)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    func hideTabBar(isHidden: Bool) {
        tabBarController?.tabBar.isHidden = isHidden
    }
    func reloadData() {
        tableView.reloadData()
    }
    func showErrorMessage(_ errorMessage: String) {
        let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .cancel))
        navigationController?.present(alert, animated: true)
    }
}
