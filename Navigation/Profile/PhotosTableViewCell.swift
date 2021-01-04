//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Andrey Antipov on 18.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit
import SnapKit

final class PhotosTableViewCell: UITableViewCell {

    var photo1: String? {
        didSet {
            guard let photo = photo1 else { return }
            photoImageView1.image = UIImage(named: photo)
        }
    }
    var photo2: String? {
        didSet {
            guard let photo = photo2 else { return }
            photoImageView2.image = UIImage(named: photo)
        }
    }
    var photo3: String? {
        didSet {
            guard let photo = photo3 else { return }
            photoImageView3.image = UIImage(named: photo)
        }
    }
    var photo4: String? {
        didSet {
            guard let photo = photo4 else { return }
            photoImageView4.image = UIImage(named: photo)
        }
    }

    /// Название Photos
    private let photosLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = SystemColors.textFieldTextColor
        label.text = "Photos"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.toAutoLayout()
        return label
    }()

    /// Кнопка перехода в фотогалерею
    private lazy var showPhotoGalleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        // Set the button normal state background image.
        button.setBackgroundImage(UIImage(named: "arrow.right"), for: UIControl.State.normal)
        // Set the button highlighted state background image.
        button.setBackgroundImage(UIImage(named: "arrow.right"), for: UIControl.State.highlighted)
        //button.addTarget(self, action: #selector(showPhotoGalleryButtonTapped), for: .touchUpInside)
        return button
    }()

    /// Картинка (фото 1)
    private let photoImageView1: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = SystemColors.imageViewBackgroundColor
        imageView.toAutoLayout()
        return imageView
    }()

    /// Картинка (фото 2)
    private let photoImageView2: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = SystemColors.imageViewBackgroundColor
        imageView.toAutoLayout()
        return imageView
    }()

    /// Картинка (фото 3)
    private let photoImageView3: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = SystemColors.imageViewBackgroundColor
        imageView.toAutoLayout()
        return imageView
    }()

    /// Картинка (фото 4)
    private let photoImageView4: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = SystemColors.imageViewBackgroundColor
        imageView.toAutoLayout()
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupLayout()

    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: Layout
    func setupLayout() {
        contentView.addSubview(photosLabel)
        contentView.addSubview(showPhotoGalleryButton)
        contentView.addSubview(photoImageView1)
        contentView.addSubview(photoImageView2)
        contentView.addSubview(photoImageView3)
        contentView.addSubview(photoImageView4)
        
        // Constraints for photosLabel
        photosLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(12)
            make.left.equalTo(contentView).offset(12)
        }
        // Constraints for photoImageView1
        photoImageView1.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(photosLabel.snp.bottom).offset(12)
            make.left.equalTo(contentView).offset(12)
            make.bottom.equalTo(contentView).offset(-12)
            make.width.equalTo(contentView).multipliedBy(0.25).offset(-12)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.25).offset(-12)
            make.right.equalTo(photoImageView2.snp.left).offset(-8)
        }
        // Constraints for photoImageView2
        photoImageView2.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(photosLabel.snp.bottom).offset(12)
            make.bottom.equalTo(contentView).offset(-12)
            make.width.equalTo(contentView).multipliedBy(0.25).offset(-12)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.25).offset(-12)
            make.right.equalTo(photoImageView3.snp.left).offset(-8)
        }
        // Constraints for photoImageView3
        photoImageView3.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(photosLabel.snp.bottom).offset(12)
            make.bottom.equalTo(contentView).offset(-12)
            make.width.equalTo(contentView).multipliedBy(0.25).offset(-12)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.25).offset(-12)
            make.right.equalTo(photoImageView4.snp.left).offset(-8)
        }
        // Constraints for photoImageView4
        photoImageView4.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(photosLabel.snp.bottom).offset(12)
            make.bottom.equalTo(contentView).offset(-12)
            make.width.equalTo(contentView).multipliedBy(0.25).offset(-12)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.25).offset(-12)
        }
        // Constraints for showPhotoGalleryButton
        showPhotoGalleryButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(photosLabel.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(-12)
        }
    }
}
