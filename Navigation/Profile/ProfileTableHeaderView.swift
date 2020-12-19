//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Andrey Antipov on 18.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit

private enum State {
    case expanded
    case collapsed

    var change: State {
        switch self {
        case .expanded: return .collapsed
        case .collapsed: return .expanded
        }
    }
}

class ProfileTableHeaderView: UIView {

    // Avatar frame
    private var initialFrame: CGRect {
        return profileImageContainer.frame
    }
    // For avatar state: collapsed or expanded
    private var state: State = .collapsed

    // Property animator for avatar and view
    private lazy var mainAnimator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.5, curve: .linear)
    }()
    // Control animation of button
    private lazy var closeButtonAnimator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.3, curve: .linear)
    }()

    private lazy var profileImageContainer: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.toAutoLayout()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()

    // Avatar tap
    private lazy var tapAvatarGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar(recognizer:)))
        return tapGesture
    }()

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.backgroundColor = .darkGray
        imageView.clipsToBounds = true
        // Interaction sensetive is true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.toAutoLayout()
        button.alpha = 0
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var profileNameLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()

    private lazy var profileStatusLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 2
        label.textAlignment = .left
        return label
    }()

    // ***
    private lazy var profileStatusTextField: UITextField = {
        let textField = UITextField()
        textField.insertLeftIndent()
        textField.toAutoLayout()
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.textAlignment = .left
        return textField
    }()
    // ***

    private lazy var showStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setTitle("Set status", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.roundCornersWithRadius(4, top: true, bottom: true, shadowEnabled: true)
        button.setShadowPath()

        button.addTarget(self, action: #selector(showStatusButtonTapped), for: .touchUpInside)
        return button
    }()

    // Using table
    private var tableView: UITableView?

    // Shield for the whole screen
    private lazy var blindView: UIView = {
        let view = UIView(frame: .zero)
        view.toAutoLayout()
        view.backgroundColor = UIColor.gray
        view.alpha = 0
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        // Register a handler for clicking on a picture to start the animation
        profileImageView.addGestureRecognizer(tapAvatarGesture)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Configure cell with selected device
    /// - Parameter profile: Profile
    /// - Parameter tableView: UITableView
    func configure(_ profile: Profile, tableView: UITableView) {
        profileImageView.image = UIImage(named: profile.image)
        //profileImageStackView.imageName = profile.image
        profileNameLabel.text = profile.name
        profileStatusLabel.text = profile.status
        profileStatusTextField.text = profile.status
        self.tableView = tableView

        setupLayout()
    }

    // MARK: Actions
    @objc private func showStatusButtonTapped() {
        profileStatusLabel.text = profileStatusTextField.text
        endEditing(true)
    }

    @objc private func closeButtonTapped(_ sender: Any) {
        toggle()
    }

    @objc private func didTapBackground(recognizer: UITapGestureRecognizer) {
        // Hide keyboard
        endEditing(true)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if state == .collapsed {
            profileImageView.roundCornersWithRadius(profileImageView.bounds.height/2,
                                                    top: true, bottom: true, shadowEnabled: false)
        }

        showStatusButton.setShadowPath()
    }
}

// MARK: Layout
extension ProfileTableHeaderView {
    func addAllSubviews() {
        addSubview(profileImageContainer)
        addSubview(profileNameLabel)
        addSubview(profileStatusLabel)
        addSubview(profileStatusTextField)
        addSubview(showStatusButton)
        addSubview(blindView)
        addSubview(profileImageView)
        addSubview(closeButton)

        layoutMarginsDidChange()
    }

    func setupLayout() {
        addAllSubviews()
        // constraint for collapsed state
        let topMinAnchor = profileImageView.topAnchor.constraint(equalTo: profileImageContainer.topAnchor)
        topMinAnchor.identifier = "topMinAnchor"

        let leadingMinAnchor = profileImageView.leadingAnchor.constraint(equalTo: profileImageContainer.leadingAnchor)
        leadingMinAnchor.identifier = "leadingMinAnchor"
        let trailingMinAnchor = profileImageView.trailingAnchor.constraint(
            equalTo: profileImageContainer.trailingAnchor)
        trailingMinAnchor.identifier = "trailingMinAnchor"

        let bottomMinAnchor = profileImageView.bottomAnchor.constraint(equalTo: profileImageContainer.bottomAnchor)
        bottomMinAnchor.identifier = "bottomMinAnchor"

        // All constraints
        let constraints = [
            profileImageContainer.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            profileImageContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            profileImageContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            profileImageContainer.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            topMinAnchor, leadingMinAnchor, trailingMinAnchor, bottomMinAnchor,
            profileNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 27),
            profileNameLabel.leadingAnchor.constraint(equalTo: profileImageContainer.trailingAnchor, constant: 16),
            profileNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileStatusLabel.leadingAnchor.constraint(equalTo: profileImageContainer.trailingAnchor, constant: 16),
            profileStatusLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileStatusTextField.leadingAnchor.constraint(equalTo: profileImageContainer.trailingAnchor,
                                                            constant: 16),
            profileStatusTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            profileStatusTextField.topAnchor.constraint(equalTo: profileStatusLabel.bottomAnchor, constant: 5),
            profileStatusTextField.heightAnchor.constraint(equalToConstant: 40),
            showStatusButton.topAnchor.constraint(equalTo: profileStatusTextField.bottomAnchor, constant: 16),

            showStatusButton.topAnchor.constraint(equalTo: profileImageContainer.bottomAnchor, constant: 16),
            showStatusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            showStatusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            showStatusButton.heightAnchor.constraint(equalToConstant: 50),

            showStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
          ]

        NSLayoutConstraint.activate(constraints)
    }
}

// MARK: Avatar animation
extension ProfileTableHeaderView {
    func toggle() {
        switch state {
        case .expanded:
            collapse()
        case .collapsed:
            expand()
        }
    }

    // Expanded animation
    private func expandLayout() {
        // Check: root in second level upper
        guard let rootSV = superview?.superview else { return }

        // Expand blind
        let topBlindAnchor = self.blindView.topAnchor.constraint(equalTo: rootSV.topAnchor)
        topBlindAnchor.identifier = "topBlindAnchor"
        topBlindAnchor.isActive = true
        let leadingBlindAnchor = self.blindView.leadingAnchor.constraint(equalTo: rootSV.leadingAnchor)
        leadingBlindAnchor.identifier = "leadingBlindAnchor"
        leadingBlindAnchor.isActive = true
        let trailingBlindAnchor = self.blindView.trailingAnchor.constraint(equalTo: rootSV.trailingAnchor)
        trailingBlindAnchor.identifier = "trailingBlindAnchor"
        trailingBlindAnchor.isActive = true
        let bottomBlindAnchor = self.blindView.bottomAnchor.constraint(equalTo: rootSV.bottomAnchor)
        bottomBlindAnchor.identifier = "bottomBlindAnchor"
        bottomBlindAnchor.isActive = true
        let widthBlindAnchor = self.blindView.widthAnchor.constraint(equalTo: rootSV.widthAnchor)
        widthBlindAnchor.identifier = "widthBlindAnchor"
        widthBlindAnchor.isActive = true
        let heightBlindAnchor = self.blindView.heightAnchor.constraint(equalTo: rootSV.heightAnchor)
        heightBlindAnchor.identifier = "heightBlindAnchor"
        heightBlindAnchor.isActive = true
        // Button in the upper right corner
        let topСloseButtonAnchor = self.closeButton.topAnchor.constraint(equalTo: rootSV.safeAreaLayoutGuide.topAnchor,
                                                                          constant: 10)
        topСloseButtonAnchor.identifier = "topСloseButtonAnchor"
        topСloseButtonAnchor.isActive = true
        let trailingСloseButtonAnchor = self.closeButton.trailingAnchor.constraint(
            equalTo: rootSV.safeAreaLayoutGuide.trailingAnchor)
        trailingСloseButtonAnchor.identifier = "trailingСloseButtonAnchor"
        trailingСloseButtonAnchor.isActive = true
        NSLayoutConstraint.activate([topBlindAnchor, leadingBlindAnchor,
                                     trailingBlindAnchor, bottomBlindAnchor,
                                     widthBlindAnchor, heightBlindAnchor,
                                     topСloseButtonAnchor, trailingСloseButtonAnchor])
        self.layoutIfNeeded()
    }

    private func expand() {
        // Check: has table defined?
        guard let tableView = self.tableView else { return }
        // Check: root in second level upper
        guard let rootSV = superview?.superview else { return }

        expandLayout()
        mainAnimator.addAnimations {
            self.state = self.state.change
            let safeFrame: CGRect = rootSV.safeAreaLayoutGuide.layoutFrame
            //self.initialFrame = self.profileImageView.frame
            let mainSize: CGFloat
            if safeFrame.width <= safeFrame.height {
                // Weight is main size
                mainSize = safeFrame.width
            } else {
                // Height is main size
                mainSize = safeFrame.height
            }
            self.profileImageView.frame = CGRect(x: CGFloat(safeFrame.width/2 - self.initialFrame.width/2),
                                                 y: CGFloat(safeFrame.height/2 - self.initialFrame.width/2 +
                                                            safeFrame.origin.y),
                                                 width: CGFloat(self.initialFrame.width),
                                                 height: CGFloat(self.initialFrame.height))
            self.profileImageView.transform = self.profileImageView.transform.scaledBy(
                x: mainSize/self.initialFrame.width, y: mainSize/self.initialFrame.height)
            self.profileImageView.layer.borderWidth = 3
            self.profileImageView.layer.cornerRadius = 0
            self.blindView.alpha = 1

            self.layoutIfNeeded()
        }

        closeButtonAnimator.addAnimations {
            self.closeButton.alpha = 1
            self.layoutIfNeeded()
        }

        mainAnimator.addCompletion { position in
            switch position {
            case .end:
                self.closeButtonAnimator.startAnimation()
                tableView.isScrollEnabled = false
                tableView.allowsSelection = false
            default:
                ()
            }
        }
        mainAnimator.startAnimation()
    }

    private func collapse() {
        guard let tableView = self.tableView else { return }

        closeButtonAnimator.addAnimations {
            self.closeButton.alpha = 0
            self.layoutIfNeeded()
        }

        mainAnimator.addAnimations {
            self.state = self.state.change

            self.blindView.alpha = 0
            self.profileImageView.roundCornersWithRadius(self.initialFrame.height/2,
                                                         top: true, bottom: true, shadowEnabled: false)

            self.profileImageView.transform = self.profileImageView.transform.scaledBy(
                x: self.initialFrame.width/self.profileImageView.frame.width,
                y: self.initialFrame.height/self.profileImageView.frame.height)

            self.profileImageView.frame = self.initialFrame

            self.layoutIfNeeded()
        }

        closeButtonAnimator.addCompletion { position in
            switch position {
            case .end:
                self.mainAnimator.startAnimation()
                tableView.isScrollEnabled = true
                tableView.allowsSelection = true
            default:
                ()
            }
        }
        closeButtonAnimator.startAnimation()
    }
    @objc private func didTapAvatar(recognizer: UITapGestureRecognizer) {
        toggle()
    }
}
