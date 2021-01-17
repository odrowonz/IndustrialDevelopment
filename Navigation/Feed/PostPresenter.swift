//
//  PostPresenter.swift
//  Navigation
//
//  Created by Andrey Antipov on 27.12.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit
class PostPresenter: FeedViewOutput {
    var flowCoordinator: FeedCoordinator
    
    init(_ flowCoordinator: FeedCoordinator) {
        self.flowCoordinator = flowCoordinator
    }
    
    func showPost(_ post: Post) {
        flowCoordinator.gotoPost(post)
    }
}
