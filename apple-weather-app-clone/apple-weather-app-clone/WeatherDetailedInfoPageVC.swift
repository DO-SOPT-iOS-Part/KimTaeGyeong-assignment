//
//  WeatherDetailedInfoPageVC.swift
//  apple-weather-app-clone
//
//  Created by 티모시 킴 on 11/1/23.
//

import UIKit

import SnapKit

class WeatherDetailedInfoPageVC: UIPageViewController {
    
    var weatherInfoViewList:[WeatherInfoView] = []
    
    var initialPage = 0
    private var pages = [UIViewController]()
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    private let toolbar: UIToolbar = {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        toolbar.backgroundColor = .clear
        toolbar.tintColor = UIColor.black.withAlphaComponent(0.1)
        toolbar.barTintColor = .clear
        toolbar.setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        return toolbar
    }()
    
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
    
    private let listButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "list_image"), for: .normal)
        return button
    }()
    
    init(weatherInfoViewList: [WeatherInfoView]) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        self.weatherInfoViewList = weatherInfoViewList
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
        setUI()
        setDelegate()
        setHierarchy()
        setLayout()
        setToolBar()
        setAddTarget()
    }
    
}

extension WeatherDetailedInfoPageVC {
    
    func setPage() {
        for i in 0..<weatherInfoViewList.count {
            let weatherDetailedInfoVC = WeatherDetailedInfoVC(location: weatherInfoViewList[i].locationLabel.text!, temperature: weatherInfoViewList[i].temperatureLabel.text!, weather: weatherInfoViewList[i].weatherLabel.text!, maxTemperature: weatherInfoViewList[i].maxtemperatureLabel.text!, minTemperature: weatherInfoViewList[i].mintemperatureLabel.text!)
            pages.append(weatherDetailedInfoVC)
        }
        self.pageControl.numberOfPages = weatherInfoViewList.count
        self.pageControl.setIndicatorImage(UIImage(named: "gps_image"), forPage: 0)
        self.pageControl.currentPage = initialPage
    }
    
    func setDelegate() {
        self.dataSource = self
        self.delegate = self
    }
    
    func setUI() {
        self.setViewControllers([pages[initialPage]], direction: .forward, animated: true)
    }
    
    func setHierarchy() {
        view.addSubview(toolbar)
        view.addSubview(lineView)
    }
    
    func setLayout() {
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
    
    func setToolBar() {
        let leftButton = UIBarButtonItem(customView: mapButton)
        let rightButton = UIBarButtonItem(customView: listButton)
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let pageControl = UIBarButtonItem(customView: pageControl)
        toolbar.setItems([leftButton, flexibleSpace, pageControl, flexibleSpace, rightButton], animated: true)
    }
    
    func setAddTarget() {
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

