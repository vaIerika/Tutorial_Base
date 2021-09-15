//
//  MainCoordinator.swift
//  Coordinators
//
//  Created by Valerie 👩🏼‍💻 on 15/09/2021.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// the method used in SceneDelegate only
    func start() {
        let viewContoller = ViewController.instantiate()
        viewContoller.coordinator = self
        navigationController.pushViewController(viewContoller, animated: false)
    }
    
    func buySubscription() {
        let viewController = BuyViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func createAccount() {
        let viewController = CreateAccountViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
