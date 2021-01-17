//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Andrey Antipov on 06.01.2021.
//  Copyright © 2021 Andrey Antipov. All rights reserved.
//

import UIKit

class AppCoordinator: MainCoordinator {
    /// Feed tab bar navigation
    lazy var feedNavigationController: UINavigationController = {
        var nav = UINavigationController()
        let title = "Feed"
        let image = UIImage(named: "house.fill")
        nav.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        return nav
    }()
    /// Profile tab bar navigation
    lazy var profileNavigationController: UINavigationController = {
        var nav = UINavigationController()
        let title = "Profile"
        let image = UIImage(named: "person.fill")
        nav.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        return nav
    }()
    
    var tabBarController: UITabBarController
    var flowCoordinators = [FlowCoordinator]()

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    func start() {
        flowCoordinators = [
            FeedCoordinator(navigationController: feedNavigationController, mainCoordinator: self),
            ProfileCoordinator(navigationController: profileNavigationController, mainCoordinator: self)
        ]
        
        for coordinator in flowCoordinators {
            coordinator.start()
        }
        
        // Add tab bars controllers
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
    }
}
