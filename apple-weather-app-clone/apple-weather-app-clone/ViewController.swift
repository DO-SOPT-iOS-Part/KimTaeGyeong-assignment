//
//  ViewController.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/20/23.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var rightBarButtonItem: UIBarButtonItem = {
        var button = UIBarButtonItem()
        button.isHidden = false
        button.image = UIImage(named: "ellipsis_image")
        button.tintColor = .white
        return button
    }()
    
    private let locationSearchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.searchTextField
            .attributedPlaceholder = NSAttributedString(string: "도시 또는 공항 검색", attributes: [NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.6178889275, green: 0.6178889275, blue: 0.6178889275, alpha: 1)])
        searchController.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.1353607476, green: 0.1353607476, blue: 0.1353607476, alpha: 1)
        searchController.searchBar.searchTextField.textColor = .white
        searchController.searchBar.tintColor = .white
        searchController.searchBar.setValue("취소", forKey: "cancelButtonText")
        searchController.hidesNavigationBarDuringPresentation = true
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.title = "날씨"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.setSearchController()
        
    }
    
}

extension ViewController {
    
    private func setSearchController() {
        self.navigationItem.searchController = locationSearchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.locationSearchController.searchBar.searchTextField.textColor = .white
        self.locationSearchController.searchBar.searchTextField.leftView?.tintColor = #colorLiteral(red: 0.6178889275, green: 0.6178889275, blue: 0.6178889275, alpha: 1)
    }
    
}
