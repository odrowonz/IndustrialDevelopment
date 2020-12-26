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
    
    func showPost(_ post: Post?) {
        let vc = PostViewController()
        vc.post = post
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
