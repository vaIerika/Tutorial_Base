//
//  BuyCoordinator.swift
//  Coordinators
//
//  Created by Valerie 👩🏼‍💻 on 16/09/2021.
//

import UIKit

class BuyCoordinator: Coordinator {
    /// Option 1.
    //weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var selectedProduct: Int = 0 
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = BuyViewController.instantiate()
        viewController.coordinator = self
        viewController.selectedProduct = selectedProduct
        navigationController.pushViewController(viewController, animated: true)
    }
    
    /// Option 1. To move back
    /*
    func didFinishBuying() {
        parentCoordinator?.childDidFinish(self)
    }
     */
}
