//
//  MainCoordinator.swift
//  Coordinators
//
//  Created by Valerie 👩🏼‍💻 on 15/09/2021.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    /// the method used in SceneDelegate only
    func start() {
        navigationController.delegate = self    /// Option 2. To move back
        
        let viewController = ViewController.instantiate()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)   /// for bar bar to work
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func buySubscription(to productType: Int) {
        let child = BuyCoordinator(navigationController: navigationController)
        /// Option 1.
        //child.parentCoordinator = self
        child.selectedProduct = productType
        childCoordinators.append(child)
        child.start()
    }
    
    func createAccount() {
        let viewController = CreateAccountViewController.instantiate()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}

/// Option 2. To move back
extension MainCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {  return }
        
        /// pushing vc on the top rather than popping it
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        /// popping vc, typecasting
        if let buyViewController = fromViewController as? BuyViewController {
            childDidFinish(buyViewController.coordinator)
        }
    }
}
