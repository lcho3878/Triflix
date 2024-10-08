//
//  TabBarViewController.swift
//  Triflix
//
//  Created by 이찬호 on 10/8/24.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        configureTabBar()
    }
    
    private func configureTabBar() {
        tabBar.backgroundColor = .white
        
        let trendVC = TrendingViewController()
        let trendNav = UINavigationController(rootViewController: trendVC)
        trendNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let searchVC = SearchViewController()
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.tabBarItem = UITabBarItem(title: "Top Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let favoriteVC = FavoriteViewController()
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)
        favoriteNav.tabBarItem = UITabBarItem(title: "Download", image: UIImage(systemName: "face.smiling"), tag: 2)
        
        setViewControllers([trendNav, searchNav, favoriteNav], animated: true)
    }
}
