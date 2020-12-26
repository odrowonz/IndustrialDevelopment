//
//  FeedStackView.swift
//  Navigation
//
//  Created by Andrey Antipov on 27.12.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit

class FeedStackView: UIStackView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        setupLayout()
    }
    
    // Get first post, if exists
    let post0: Post? = {
        guard Storage.posts.count > 0 else { return nil }
        return Storage.posts[0]
    }()
    let post1: Post? = {
        guard Storage.posts.count > 1 else { return nil }
        return Storage.posts[1]
    }()
    
    var onTap: ((Post?) -> Void)?
    
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
        switch (sender.tag) {
        case 0: onTap?(post0)
        case 1: onTap?(post1)
        default: onTap?(nil)
        }
    }
    
    // MARK: Layout
    private func setupLayout() {
        addSubview(showPost0Button)
        addSubview(showPost1Button)
        
        let constraints = [
            showPost0Button.topAnchor.constraint(equalTo: self.topAnchor),
            showPost0Button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            showPost0Button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            showPost0Button.heightAnchor.constraint(equalToConstant: 40),
            
            showPost1Button.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            showPost1Button.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            showPost1Button.heightAnchor.constraint(equalToConstant: 40),
            showPost1Button.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
