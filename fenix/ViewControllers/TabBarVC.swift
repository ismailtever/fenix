//
//  TabBarVC.swift
//  fenix
//
//  Created by Ismail Tever on 2.12.2023.
//

import UIKit
import SnapKit

class TabBarVC: UITabBarController {
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarController()
    }
    
    //MARK: - Functions
    
    private func setupTabBarController() {
        let viewController1 = MovieVC()
        let viewController2 = FavVC()
        
        let vC = [viewController1, viewController2]
        
        viewController1.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        viewController2.tabBarItem = UITabBarItem(title: "Watch List", image: UIImage(systemName: "bookmark"), tag: 1)
        
        self.viewControllers = vC
        
        tabBar.backgroundColor = #colorLiteral(red: 0.1329745948, green: 0.1571635008, blue: 0.1828652918, alpha: 1)
        tabBar.tintColor = .white
        tabBar.unselectedItemTintColor = .gray
        
        let lineView = UIView()
        lineView.backgroundColor = #colorLiteral(red: 0.1131399944, green: 0.3783294857, blue: 0.551776588, alpha: 1)
        tabBar.addSubview(lineView)
        
        lineView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.leading.trailing.equalTo(tabBar)
            make.bottom.equalTo(tabBar.snp.top)
        }
    }
}

