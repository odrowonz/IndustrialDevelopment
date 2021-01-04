//
//  FeedViewOutput.swift
//  Navigation
//
//  Created by Andrey Antipov on 27.12.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit
protocol FeedViewOutput {
    var navigationController: UINavigationController? { get set }
    
    func showPost(_ post: Post?)
}
