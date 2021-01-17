//
//  InfoViewController.swift
//  Navigation
//
//  Created by Andrey Antipov on 18.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    var post: Post?

    var cancelFinalAction: (() -> Void)?
    var deleteFinalAction: (() -> Void)?

    private lazy var mainButton: UIButton = {
        let button = UIButton()
        button.toAutoLayout()
        button.setTitle("Show Alert", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.roundCornersWithRadius(4, top: true, bottom: true, shadowEnabled: true)
        button.setShadowPath()

        button.addTarget(self, action: #selector(showAlertButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemYellow
        // Do any additional setup after loading the view.
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(mainButton)

        let safe = view.safeAreaLayoutGuide

        let constraints = [
            mainButton.centerXAnchor.constraint(equalTo: safe.centerXAnchor),
            mainButton.centerYAnchor.constraint(equalTo: safe.centerYAnchor),
            mainButton.widthAnchor.constraint(equalToConstant: 110),
            mainButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc private func showAlertButtonTapped(_ sender: Any) {
        let alertController = UIAlertController(title: "Delete this post?",
                                                message: "You cannot restore this post",
                                                preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { _ in
            if let nvc = self.navigationController {
                // if it use navigation controller, just pop ViewController
                nvc.popViewController(animated: true)
            } else {
                // otherwise, dismiss it
                self.dismiss(animated: true, completion: nil)
            }
            self.cancelFinalAction?()
        }
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            if let nvc = self.navigationController {
                // if it use navigation controller, just pop ViewController
                nvc.popViewController(animated: true)
            } else {
                // otherwise, dismiss it
                self.dismiss(animated: true, completion: nil)
            }
            self.deleteFinalAction?()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
