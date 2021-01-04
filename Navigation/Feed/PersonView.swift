//
//  PersonView.swift
//  Navigation
//
//  Created by Andrey Antipov on 20.12.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit
import SnapKit
import iOSIntPackage

class PersonView: UIView {
    
   var named: String? {
        didSet {
            if let named = named,
               let img = UIImage(named: named) {
                let processor = ImageProcessor()
                processor.processImage(sourceImage: img, filter: .colorInvert) { (image) in
                    profileImageView.image = image
                }
            }
        }
    }
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.toAutoLayout()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 3
        imageView.layer.masksToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.backgroundColor = .darkGray
        imageView.clipsToBounds = true
        // Make image sensitive for tap
        //imageView.isUserInteractionEnabled = true
        return imageView
    }()

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        addSubview(profileImageView)
        
        // All constraints in superview frame
        self.profileImageView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
}
