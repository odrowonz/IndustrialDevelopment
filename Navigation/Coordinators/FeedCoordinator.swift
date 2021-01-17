//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Andrey Antipov on 07.01.2021.
//  Copyright © 2021 Andrey Antipov. All rights reserved.
//

import UIKit

class FeedCoordinator: FlowCoordinator {
    lazy var postPresenter = PostPresenter(self)
    
    var navigationController: UINavigationController
    weak var mainCoordinator: AppCoordinator?

    init(navigationController: UINavigationController, mainCoordinator: AppCoordinator?) {
        self.navigationController = navigationController
        self.mainCoordinator = mainCoordinator
    }

    func start() {
        let vc = FeedViewController(output: postPresenter)
        navigationController.pushViewController(vc, animated: false)
    }
    
    func backtoRoot() {
        // Guard of action's body
        guard navigationController.viewControllers.count > 0 else { return }
        // Go to root controller
        navigationController.popToRootViewController(animated: true)
    }
    
    func gotoPost(_ post: Post) {
        let vc = PostViewController()
        vc.flowCoordinator = self
        vc.post = post
        navigationController.pushViewController(vc, animated: true)
    }
    
    func gotoInfo(_ post: Post) {
        let vc = InfoViewController()
        vc.post = post
        vc.cancelFinalAction = nil
        vc.deleteFinalAction = { [weak self] in
            self?.backtoRoot()
        }
        navigationController.present(vc, animated: true)
    }
}
