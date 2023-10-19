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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
}

