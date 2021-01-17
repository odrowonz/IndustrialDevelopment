//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Andrey Antipov on 06.01.2021.
//  Copyright © 2021 Andrey Antipov. All rights reserved.
//

import UIKit

protocol MainCoordinator {
    var tabBarController: UITabBarController { get set }
    var flowCoordinators: [FlowCoordinator] { get set }

    func start()
}
