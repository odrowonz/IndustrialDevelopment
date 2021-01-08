//
//  FlowCoordinator.swift
//  Navigation
//
//  Created by Andrey Antipov on 06.01.2021.
//  Copyright © 2021 Andrey Antipov. All rights reserved.
//

import UIKit

protocol FlowCoordinator {
    var mainCoordinator: MainCoordinator { get set }
    var navigationController: UINavigationController { get set }

    func start()
    func backtoRoot()
}

