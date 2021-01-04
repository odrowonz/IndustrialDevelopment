//
//  PostPresenter.swift
//  Navigation
//
//  Created by Andrey Antipov on 27.12.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit
class PostPresenter: FeedViewOutput {
    var navigationController: UINavigationController?
    lazy var postViewController = PostViewController()
    
    func showPost(_ post: Post?) {
        postViewController.post = post
        self.navigationController?.pushViewController(postViewController, animated: true)
    }
}
