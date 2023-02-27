//
//  SearchCell.swift
//  FoodStation
//
//  Created by admin on 22.02.2023.
//

import UIKit

protocol SearchCellDelegate{
    func textDidChange(text: String)
}
class SearchCell: UICollectionViewCell{
    //MARK: - Properties
    
    var delegate: SearchCellDelegate?
    
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        searchBar.searchTextField.borderStyle = .roundedRect
        searchBar.searchTextField.returnKeyType = .search
        searchBar.searchTextField.layer.borderWidth = 2
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.layer.borderColor = UIColor(named: "bgColor1")?.cgColor
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.font = UIFont(name: "OpenSans-Regular", size: 18)
        searchBar.searchTextField.textColor = .black
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        return searchBar
    }()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Configuration
    func configUI(){
        addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
//MARK: - SearchBarDelegate Methods
extension SearchCell: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty{
            delegate?.textDidChange(text: searchText)
            searchBar.endEditing(true)
        }else{
            delegate?.textDidChange(text: searchText)
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}
