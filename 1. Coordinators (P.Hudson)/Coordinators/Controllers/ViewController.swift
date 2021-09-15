//
//  ViewController.swift
//  Coordinators
//
//  Created by Valerie 👩🏼‍💻 on 15/09/2021.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buyButtonPressed(_ sender: Any) {
        coordinator?.buySubscription()
    }
    
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        coordinator?.createAccount()
    }
}

