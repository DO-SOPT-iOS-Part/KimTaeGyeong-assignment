//
//  WeatherDetailedInfoPageVC.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 11/1/23.
//

import UIKit

import SnapKit
import Then

class WeatherDetailedInfoPageVC: UIPageViewController {
    
    var initialPage = 0
    
    private var pages = [UIViewController]()
    private let pageControl = UIPageControl()
    private let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    private let lineView = UIView()
    private let mapButton = UIButton()
    private let listButton = UIButton()
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPage()
        self.setDelegate()
        self.setUI()
        self.setToolBar()
        self.setAddTarget()
    }
    
}

extension WeatherDetailedInfoPageVC {
    
    private func setPage() {
        for i in 0..<weatherInfoListData.count {
            let weatherDetailedInfoVC = WeatherDetailedInfoVC()
            weatherDetailedInfoVC.bindData(data: weatherInfoListData[i])
            pages.append(weatherDetailedInfoVC)
        }
        self.pageControl.numberOfPages = weatherInfoListData.count
        self.pageControl.setIndicatorImage(UIImage(named: "gps_image"), forPage: 0)
        self.pageControl.currentPage = initialPage
        self.setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
    
    private func setDelegate() {
        self.dataSource = self
        self.delegate = self
    }
    
    private func setUI() {
        setStyle()
        setLayout()
    }
    
    private func setStyle() {
        toolbar.do {
            $0.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1882352941, blue: 0.2509803922, alpha: 1)
            $0.tintColor = UIColor.black.withAlphaComponent(0.1)
            $0.barTintColor = .clear
            $0.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        lineView.do {
            $0.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        }
        
        mapButton.do {
            $0.setImage(UIImage(named: "map_image"), for: .normal)
        }
        
        listButton.do {
            $0.setImage(UIImage(named: "list_image"), for: .normal)
        }
    }
    
    private func setLayout() {
        [toolbar, lineView].forEach {
            view.addSubview($0)
        }
        
        toolbar.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(62)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(toolbar.snp.top)
            $0.height.equalTo(1)
        }
    }
    
    private func setToolBar() {
        let leftButton = UIBarButtonItem(customView: mapButton)
        let rightButton = UIBarButtonItem(customView: listButton)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let pageControl = UIBarButtonItem(customView: pageControl)
        toolbar.setItems([leftButton, flexibleSpace, pageControl, flexibleSpace, rightButton], animated: true)
    }
    
    private func setAddTarget() {
        listButton.addTarget(self, action: #selector(listButtonPressed(_:)), for: .touchUpInside)
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }
    
    @objc func listButtonPressed(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func pageControlTapped(_ sender: UIPageControl) {
        let currentPage = sender.currentPage
        let currentViewController = pages[currentPage]
        setViewControllers([currentViewController], direction: .forward, animated: false, completion: nil)
    }
    
}

extension WeatherDetailedInfoPageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        guard currentIndex > 0 else { return nil }
        return pages[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        guard currentIndex < (pages.count - 1) else { return nil }
        return pages[currentIndex + 1]
    }
    
}

extension WeatherDetailedInfoPageVC: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed else { return }
        if let currentViewController = viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            pageControl.currentPage = currentIndex
        }
    }
    
}
