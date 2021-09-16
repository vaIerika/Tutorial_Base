//
//  MainTabBarController.swift
//  Coordinators
//
//  Created by Valerie 👩🏼‍💻 on 16/09/2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    /// tabs
    let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
    let historyCoordinator = HistoryCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCoordinator.start()
        historyCoordinator.start()
        viewControllers = [mainCoordinator.navigationController, historyCoordinator.navigationController]    /// has to have TabBarItems
    }
}
