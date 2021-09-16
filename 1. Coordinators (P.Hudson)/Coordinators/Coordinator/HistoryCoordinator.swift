//
//  HistoryCoordinator.swift
//  Coordinators
//
//  Created by Valerie 👩🏼‍💻 on 16/09/2021.
//

import UIKit

class HistoryCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HistoryViewController.instantiate()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .history, tag: 0)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
}
