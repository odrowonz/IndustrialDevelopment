//
//  LogInViewController.swift
//  Navigation
//
//  Created by Andrey Antipov on 18.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    /// Social network logo
    private lazy var logo: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        imageView.toAutoLayout()
        return imageView
    }()

    /// Login field
    private lazy var login: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Email or phone"
        textField.layer.borderColor = SystemColors.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.backgroundColor = SystemColors.textFieldBackgroundColor
        textField.textColor = SystemColors.textFieldTextColor
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = SystemColors.accentColor
        textField.autocapitalizationType = .none
        textField.roundCornersWithRadius(10, top: true, bottom: false, shadowEnabled: false)
        textField.insertLeftIndent()
        textField.toAutoLayout()
        return textField
    }()

    /// Password field
    private lazy var password: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "Password"
        textField.layer.borderColor = SystemColors.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.backgroundColor = SystemColors.textFieldBackgroundColor
        textField.textColor = SystemColors.textFieldTextColor
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.tintColor = SystemColors.accentColor
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.roundCornersWithRadius(10, top: false, bottom: true, shadowEnabled: false)
        textField.insertLeftIndent()
        textField.toAutoLayout()
        return textField
    }()

    /// LogIn button
    private lazy var logIn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()

    /// View for all UI elements
    private lazy var contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        return view
    }()

    /// Scroll view to protect the presentation of UI elements from keyboard overflow
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Background must be white
        view.backgroundColor = .white
        // All UI elements should be placed to view
        setupLayout()

        // Hide navigation bar
        navigationController?.setNavigationBarHidden(true, animated: true)

        // Keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)

        // Tap to background for hide keyboard
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapBackground))
        contentView.addGestureRecognizer(tapGesture)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

        // Remove Keyboard observers
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Keyboard actions
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo,
           let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0,
                                                   bottom: keyboardSize.height + view.safeAreaInsets.bottom,
                                                   right: 0)
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0,
                                                   bottom: keyboardSize.height + view.safeAreaInsets.bottom,
                                                   right: 0)

        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }

    // MARK: Actions
    @objc private func logInButtonTapped() {
        // Hide keyboard
        hideKeyboard()
        // Show navigation bar
        navigationController?.navigationBar.isHidden = false
        // Go to profile
        let profileController = ProfileViewController()
        navigationController?.pushViewController(profileController, animated: true)
    }

    @objc private func tapBackground() {
        // Hide keyboard
        hideKeyboard()
    }

    // MARK: Helpers
    private func setupLayout() {
        // Fit scroll view to root view
        view.addSubview(scrollView)
        // Fit content view to scroll view
        scrollView.addSubview(contentView)
        // Fit UI elements to content view
        contentView.addSubview(logo)
        contentView.addSubview(login)
        contentView.addSubview(password)
        contentView.addSubview(logIn)

        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),

            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100),

            login.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 120),
            login.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            login.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            login.heightAnchor.constraint(equalToConstant: 50),

            password.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            password.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            password.heightAnchor.constraint(equalToConstant: 50),
            password.bottomAnchor.constraint(equalTo: login.topAnchor, constant: 100),

            logIn.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 16),
            logIn.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logIn.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logIn.heightAnchor.constraint(equalToConstant: 50)
        ]

        NSLayoutConstraint.activate(constraints)
    }

    // Hide keyboard
    func hideKeyboard() {
        view.endEditing(true)
        //login.resignFirstResponder()
        //password.resignFirstResponder()
    }
}

extension LogInViewController: UIScrollViewDelegate {
}
