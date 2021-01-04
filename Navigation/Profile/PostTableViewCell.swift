//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Andrey Antipov on 18.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit
import SnapKit

class PostTableViewCell: UITableViewCell {

    var post: Post? {
        didSet {
            guard let post = post else { return }
            configure(post: post)
        }
    }

    /// Автор`(режиссер)
    private let postAuthorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = SystemColors.textFieldTextColor
        label.numberOfLines = 0
        label.textAlignment = .left
        label.toAutoLayout()
        return label
    }()

    /// Картинка (баннер)
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = SystemColors.imageViewBackgroundColor
        imageView.toAutoLayout()
        return imageView
    }()

    /// Описание
    private let postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = SystemColors.grayColor
        label.numberOfLines = 0
        label.textAlignment = .left
        label.toAutoLayout()
        return label
    }()

    /// Лайки
    private let postLikesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = SystemColors.textFieldTextColor
        label.numberOfLines = 1
        label.textAlignment = .left
        label.toAutoLayout()
        return label
    }()

    /// Просмотры
    private let postViewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = SystemColors.textFieldTextColor
        label.numberOfLines = 1
        label.textAlignment = .right
        label.toAutoLayout()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    /// Configure cell with selected device
    /// - Parameter device: Device
    func configure(post: Post) {
        postAuthorLabel.text = post.author
        postDescriptionLabel.text = post.description
        postImageView.image = UIImage(named: post.image)
        postLikesLabel.text = "Likes: " + String(post.likes)
        postViewLabel.text = "Views: " + String(post.views)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: Layout
    func setupLayout() {
        contentView.addSubview(postAuthorLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(postDescriptionLabel)
        contentView.addSubview(postLikesLabel)
        contentView.addSubview(postViewLabel)

        postAuthorLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        postImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postAuthorLabel.snp.bottom).offset(16)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(postImageView.snp.width)
        }
        
        postDescriptionLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        postLikesLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        postViewLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postDescriptionLabel.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
