//
//  TabBarController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configurationTabBarController()
        configureApperance()
        self.selectedIndex = 0
        view.backgroundColor = .black
        
    }
    
    
    private func configurationTabBarController() {
        
        let firstVC = ExchangeViewController()
        firstVC.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis")
        firstVC.tabBarItem.title = "거래소"
        firstVC.tabBarController?.selectedIndex = 0
        let firstNav = UINavigationController(rootViewController: firstVC)
        firstNav.view.backgroundColor = .white
        
        let secondVC = CoinInformationViewController()
        secondVC.tabBarItem.image = UIImage(systemName: "chart.bar.fill")
        secondVC.tabBarItem.title = "코인정보"
        secondVC.tabBarController?.selectedIndex = 1
        let secondNav = UINavigationController(rootViewController: secondVC)
        secondNav.view.backgroundColor = .white
        
        let thirdVC = RecentNesViewController()
        thirdVC.tabBarItem.image = UIImage(systemName: "star")
        thirdVC.tabBarItem.title = "최근소식"
        thirdVC.tabBarController?.selectedIndex = 2
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        thirdNav.view.backgroundColor = .white
        
        setViewControllers([firstNav, secondNav, thirdNav], animated: true)
        
    }
    
    private func configureApperance() {
        let tabBarApperance = UITabBarAppearance()
        tabBarApperance.configureWithOpaqueBackground()
        tabBarApperance.backgroundColor = .white
        
        //선택 되었을 때 컬러
        tabBarApperance.stackedLayoutAppearance.selected.iconColor = .projectNavy
        tabBarApperance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.projectNavy]
        
        //미선택일 때 컬러
        tabBarApperance.stackedLayoutAppearance.normal.iconColor = .projectGray
        tabBarApperance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.projectGray]
        
        
        // 이렇게해도 상관은 없음 이때는 UITabBarAppearance()를 안쓰는 것
//        UITabBar.appearance().unselectedItemTintColor = .projectGray
//        UITabBar.appearance().tintColor = .projectNavy
//        UITabBar.appearance().backgroundColor = .white
        
        UITabBar.appearance().standardAppearance = tabBarApperance
        
        if #available(iOS 15.0, *) {
            //ios15이상에는 이거 무조건 해줘야 함, 만약 안하면 적용 안됨
            UITabBar.appearance().scrollEdgeAppearance = tabBarApperance
        }
        
    }
    
    
    
    

}
