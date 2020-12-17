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
    let post: Post? = {
        guard Storage.posts.count > 0 else { return nil }
        return Storage.posts[0]
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
    
    private lazy var showPostButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setTitle("Open Post", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.roundCornersWithRadius(4, top: true, bottom: true, shadowEnabled: true)
        button.setShadowPath()
        
        button.addTarget(self, action: #selector(showPostButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func showPostButtonTapped(_ sender: Any) {
        let vc = PostViewController()
        vc.post = post
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
        view.addSubview(showPostButton)
        
        let safe = view.safeAreaLayoutGuide
        
        let constraints = [
            showPostButton.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            showPostButton.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            showPostButton.widthAnchor.constraint(equalToConstant: 110),
            showPostButton.heightAnchor.constraint(equalToConstant: 40)
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
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "post" else {
            return
        }
        guard let postViewController = segue.destination as? PostViewController else {
            return
        }
        postViewController.post = post
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
