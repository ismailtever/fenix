//
//  TabBarVC.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import UIKit
import SnapKit

class TabBarVC: UIViewController {

//MARK: - Properties
    
    let customTabBar = UITabBarController()
    
//MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
//MARK: - Functions

    func setupTabBarController() {
        let viewController1 = MovieVC()
        let viewController2 = FavVC()
        let vC = [viewController1, viewController2]

        viewController1.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        viewController2.tabBarItem = UITabBarItem(title: "Watch List", image: UIImage(systemName: "bookmark"), tag: 1)

        customTabBar.viewControllers = vC
        customTabBar.tabBar.backgroundColor = #colorLiteral(red: 0.1329745948, green: 0.1571635008, blue: 0.1828652918, alpha: 1)
        customTabBar.tabBar.tintColor = .white
        customTabBar.tabBar.unselectedItemTintColor = .gray
        self.addChild(customTabBar)
        
        view.addSubview(customTabBar.view)
        customTabBar.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let lineView = UIView()
        lineView.backgroundColor = #colorLiteral(red: 0.1131399944, green: 0.3783294857, blue: 0.551776588, alpha: 1)
        customTabBar.view.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1) // Çizgi yüksekliği
            make.leading.trailing.equalTo(customTabBar.tabBar)
            make.bottom.equalTo(customTabBar.tabBar.snp.top)
        }
    }
}
