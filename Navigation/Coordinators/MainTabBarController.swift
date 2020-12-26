//
//  MainTabBarController.swift
//  Navigation
//
//  Created by Andrey Antipov on 13.12.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    /// Feed tab bar
    lazy var feedTabBar: UINavigationController = {
        var nav = UINavigationController()
        let feedVC = FeedViewController(output: PostPresenter())
        nav.viewControllers = [feedVC]
        let title = "Feed"
        let image = UIImage(named: "house.fill")
        nav.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        return nav
    }()
    
    /// Profile tab bar
    lazy var profileTabBar: UINavigationController = {
        var nav = UINavigationController()
        let loginVC = LogInViewController(nibName: nil, bundle: nil)
        loginVC.authorizationDelegate = LoginInspector()
        nav.viewControllers = [loginVC]
        let title = "Profile"
        let image = UIImage(named: "person.fill")
        nav.tabBarItem = UITabBarItem(title: title, image: image, selectedImage: image)
        return nav
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Add tab bars
        viewControllers = [feedTabBar, profileTabBar]
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
