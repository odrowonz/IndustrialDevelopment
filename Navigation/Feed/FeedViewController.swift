//
//  ViewController.swift
//  Navigation
//
//  Created by Andrey Antipov on 18.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit
import SnapKit
import iOSIntPackage

final class FeedViewController: UIViewController {
    // This property identifies the task request to run in the background.
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    var output: FeedViewOutput
    
    private lazy var feedStackView: FeedStackView = {
        let feedSV = FeedStackView()
        feedSV.toAutoLayout()
        feedSV.onTap = {
            post in
            self.output.showPost(post)
        }
        return feedSV
    }()
    
    init(output: FeedViewOutput) {
        self.output = output
        super.init(nibName:nil, bundle:.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.navigationController = navigationController
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
        view.addSubview(feedStackView)

        let safe = view.safeAreaLayoutGuide
        
        let constraints = [
            feedStackView.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            feedStackView.topAnchor.constraint(equalTo: safe.topAnchor, constant: 16),
            feedStackView.widthAnchor.constraint(equalToConstant: 110),
            feedStackView.heightAnchor.constraint(equalToConstant: 96)
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
