//
//  Coordinator.swift
//  Coordinators
//
//  Created by Valerie 👩🏼‍💻 on 15/09/2021.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
