//
//  CustomBottomBarView.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 10/21/23.
//

import UIKit

class CustomBottomBarView: UIView {
    
    weak var delegate: CustomBottomBarViewDelegate?
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return view
    }()
    
    private let mapButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "map_image"), for: .normal)
        return button
    }()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = 2
        pageControl.setIndicatorImage(UIImage(named: "gps_image"), forPage: 0)
        return pageControl
    }()
    
    private let listButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "list_image"), for: .normal)
        button.addTarget(self, action: #selector(listButtonPressed(_:)), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [lineView, mapButton, pageControl, listButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.3)
        ])
        
        NSLayoutConstraint.activate([
            mapButton.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 13),
            mapButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            pageControl.topAnchor.constraint(equalTo: mapButton.topAnchor),
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            listButton.topAnchor.constraint(equalTo: mapButton.topAnchor),
            listButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    @objc private func listButtonPressed(_: UIButton) {
        delegate?.listButtonPressed(self)
    }
    
}
