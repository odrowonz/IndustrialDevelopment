//
//  PostViewController.swift
//  Navigation
//
//  Created by Andrey Antipov on 18.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    var flowCoordinator: FlowCoordinator?
    
    var post: Post?

    private lazy var barButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showInfoButtonTapped))
        return button
    }()

    @objc private func showInfoButtonTapped() {
        
        let infoController = InfoViewController()
        infoController.post = post
        infoController.cancelFinalAction = nil
        infoController.deleteFinalAction = {
            self.flowCoordinator?.backtoRoot()
        }
        navigationController?.present(infoController, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = post?.description
        // Tunning root view
        view.backgroundColor = .systemPink
        // Setup all visual elements
        self.navigationItem.setRightBarButton(barButton, animated: true)
        // Diagnostic
        print(type(of: self), #function)
    }
}
