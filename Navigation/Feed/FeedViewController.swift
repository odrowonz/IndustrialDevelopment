//
//  ViewController.swift
//  Navigation
//
//  Created by Andrey Antipov on 18.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    // This property identifies the task request to run in the background.
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    // Get first post, if exists
    let post0: Post? = {
        guard Storage.posts.count > 0 else { return nil }
        return Storage.posts[0]
    }()
    let post1: Post? = {
        guard Storage.posts.count > 1 else { return nil }
        return Storage.posts[1]
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.backgroundColor = .darkGray
        imageView.clipsToBounds = true
        // Make image sensitive for tap
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var showPost0Button: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setTitle("Open Post 0", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.roundCornersWithRadius(4, top: true, bottom: true, shadowEnabled: true)
        button.setShadowPath()
        button.tag = 0
        button.addTarget(self, action: #selector(showPostButtonTapped), for: .touchUpInside)
        return button
    }()
    private lazy var showPost1Button: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setTitle("Open Post 1", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.roundCornersWithRadius(4, top: true, bottom: true, shadowEnabled: true)
        button.setShadowPath()
        button.tag = 1
        button.addTarget(self, action: #selector(showPostButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func showPostButtonTapped(_ sender: UIButton) {
        let vc = PostViewController()
        switch (sender.tag) {
        case 0: vc.post = post0
        case 1: vc.post = post1
        default:
            vc.post = nil
        }
        navigationController?.pushViewController(vc, animated: true)
        // Diagnostic
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
      super.viewDidLoad()
      title = "Feed"
      // Tunning root view
      view.backgroundColor = .systemGreen
      // Setup all visual elements
      setupLayout()
      // Diagnostic
      print(type(of: self), #function)
    }

    // MARK: Layout
    private func setupLayout() {
        view.addSubview(showPost0Button)
        view.addSubview(showPost1Button)

        let safe = view.safeAreaLayoutGuide
        
        let constraints = [
            showPost0Button.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            showPost0Button.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            showPost0Button.widthAnchor.constraint(equalToConstant: 110),
            showPost0Button.heightAnchor.constraint(equalToConstant: 40),
            showPost1Button.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            showPost1Button.topAnchor.constraint(equalTo: showPost0Button.bottomAnchor, constant: 16),
            showPost1Button.widthAnchor.constraint(equalToConstant: 110),
            showPost1Button.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Start background mode
        registerBackgroundTask()
        
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Stop background mode
        ​endBackgroundTask()
        
        print(type(of: self), #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(type(of: self), #function)
    }
}

// Background mopde injection
extension FeedViewController {
    func registerBackgroundTask() {
        print("Background task started.")
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.​endBackgroundTask()
        }
        assert(backgroundTask != .invalid)
    }
      
    func ​endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
}
