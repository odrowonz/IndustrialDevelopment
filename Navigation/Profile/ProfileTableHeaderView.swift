//
//  ProfileTableHeaderView.swift
//  Navigation
//
//  Created by Andrey Antipov on 18.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit
import SnapKit

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

    var topMinAnchor: Constraint? = nil
    var leadingMinAnchor: Constraint? = nil
    var trailingMinAnchor: Constraint? = nil
    var bottomMinAnchor: Constraint? = nil

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
        profileImageView.snp.makeConstraints { (make) -> Void in
            self.topMinAnchor = make.top.equalTo(profileImageContainer).constraint
            self.leadingMinAnchor = make.left.equalTo(profileImageContainer).constraint
            self.trailingMinAnchor = make.right.equalTo(profileImageContainer).constraint
            self.bottomMinAnchor = make.bottom.equalTo(profileImageContainer).constraint
        }

        // All constraints
        profileImageContainer.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(profileImageContainer.snp.width)
        }
        
        closeButton.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        profileNameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(27)
            make.left.equalTo(profileImageContainer.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        profileStatusLabel.snp.makeConstraints { (make)-> Void in
            make.left.equalTo(profileImageContainer.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        profileStatusTextField.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(profileImageContainer.snp.right).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.top.equalTo(profileStatusLabel.snp.bottom).offset(5)
            make.height.equalTo(40)
        }
        
        showStatusButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(profileStatusTextField.snp.bottom).offset(16)
            make.top.equalTo(profileImageContainer.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-16)
        }
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
        
        //guard let rootSV: UIView = superview?.superview else { return }
        guard let rootSV = UIApplication.shared.keyWindow else { return }

        // Expand blind
        blindView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(rootSV.snp.top)
            make.left.equalTo(rootSV.snp.left)
            make.right.equalTo(rootSV.snp.right)
            make.bottom.equalTo(rootSV.snp.bottom)
            make.width.equalTo(rootSV.snp.width)
            make.height.equalTo(rootSV.snp.height)
        }
        
        // Button in the upper right corner
        closeButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(rootSV.safeAreaLayoutGuide).offset(10)
            make.right.equalTo(rootSV.safeAreaLayoutGuide)
        }

        self.layoutIfNeeded()
    }

    private func expand() {
        // Check: has table defined?
        guard let tableView = self.tableView else { return }
        // Check: find main window
        guard let rootSV = UIApplication.shared.keyWindow else { return }

        expandLayout()
        mainAnimator.addAnimations {
            self.state = self.state.change
            let safeFrame: CGRect = rootSV.safeAreaLayoutGuide.layoutFrame
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
