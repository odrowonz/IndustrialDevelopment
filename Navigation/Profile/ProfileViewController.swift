//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Andrey Antipov on 18.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    var flowCoordinator: ProfileCoordinator?
    
    private var posts: [Post] = [] {
        didSet {
            postTableView.reloadData()
        }
    }
    private var profiles: [Profile] = [] {
        didSet {
            postTableView.reloadData()
        }
    }

    private lazy var postTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.toAutoLayout()
        tableView.register(PostTableViewCell.self,
                           forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PhotosTableViewCell.self,
                           forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Profile"
        view.backgroundColor = .white

        // Hide navigation bar
        navigationController?.setNavigationBarHidden(true, animated: true)

        // All UI elements should be placed to view
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Hide navigation bar
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.posts = Storage.posts
        self.profiles = Storage.profiles

        // Hide navigation bar
        navigationController?.navigationBar.isHidden = true
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.posts = Storage.posts
        self.profiles = Storage.profiles

        // Hide navigation bar
        navigationController?.navigationBar.isHidden = true
    }
}

extension ProfileViewController: UITableViewDataSource {
    // Handle clicking on a cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            flowCoordinator?.gotoPhotos()
        }
    }

    // Define count of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // Define count of rows in sections
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            guard !self.posts.isEmpty else { return 0 }
            return self.posts.count
        default:
            return 0
        }
    }

    // Forms a cell of a specific row of a specific section
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self),
                                                        for: indexPath) as? PhotosTableViewCell {
                cell.photo1 = "photo_04"
                cell.photo2 = "photo_07"
                cell.photo3 = "photo_08"
                cell.photo4 = "photo_11"
                return cell
            } else { return UITableViewCell() }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self),
                                                        for: indexPath) as? PostTableViewCell {
                cell.post = self.posts[indexPath.row]
                return cell
            } else { return UITableViewCell() }
        default:
            return UITableViewCell()
        }
    }

    // Forms a header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Only sero section has header
        guard section == 0 else { return nil }

        let headerView = ProfileTableHeaderView()
        headerView.configure(self.profiles[4], tableView: tableView)
        return headerView
    }
}

// MARK: Constraints
extension ProfileViewController {
    private func setupLayout() {
        view.addSubview(postTableView)

        postTableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
    }
}

// MARK: Table Delegate
extension ProfileViewController: UITableViewDelegate {
    // Height for header of 0 section is automatic
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return .zero }
        return UITableView.automaticDimension
    }

    // Doesn't exists footers of sections
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    // Height for footer is zero
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }

    // Height for row is automatic
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
