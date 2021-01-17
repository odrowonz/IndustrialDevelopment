//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Andrey Antipov on 07.01.2021.
//  Copyright © 2021 Andrey Antipov. All rights reserved.
//

import UIKit

class ProfileCoordinator: FlowCoordinator {
    lazy var loginInspector = LoginInspector()
    
    var navigationController: UINavigationController
    weak var mainCoordinator: AppCoordinator?

    init(navigationController: UINavigationController, mainCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }

    func start() {
        let vc = LogInViewController(nibName: nil, bundle: nil)
        vc.authorizationDelegate = loginInspector
        vc.flowCoordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func backtoRoot() {
        // Guard of action's body
        guard navigationController.viewControllers.count > 0 else { return }
        // Go to root controller
        navigationController.popToRootViewController(animated: true)
    }
    
    func gotoProfile() {
        let vc = ProfileViewController()
        vc.flowCoordinator = self
        // Hide navigation bar
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(vc, animated: true)
    }
    
    func gotoPhotos() {
        let vc = PhotosViewController()
        vc.flowCoordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
