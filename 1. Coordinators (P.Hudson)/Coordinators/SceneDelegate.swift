//
//  SceneDelegate.swift
//  Coordinators
//
//  Created by Valerie 👩🏼‍💻 on 15/09/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var coordinator: MainCoordinator?
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let navigationContoller = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationContoller)
        coordinator?.start()
        
        window?.rootViewController = navigationContoller
        window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

