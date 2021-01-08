//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Andrey Antipov on 22.10.2020.
//  Copyright © 2020 Andrey Antipov. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    var flowCoordinator: FlowCoordinator?
    
    // How many maximum cells should fit in a section
    private let maxCountOfItemsInSection: Int = 3

    // How many sections with cells in total
    private var countOfSections: Int = 0

    // How many sections are filled entirely with cells
    private var countOfFullSections: Int = 0

    private var photos: [String] = [] {
        didSet {
            // How many sections with cells in total
            self.countOfSections = lroundf(Float(photos.count / maxCountOfItemsInSection))
            // How many sections are filled entirely with cells
            self.countOfFullSections = Int(photos.count / maxCountOfItemsInSection)
            // Reload the collection
            collectionView.reloadData()
        }
    }

    // Collection
    private lazy var collectionView: UICollectionView = {
        // Define the layer
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        // Create a collection with a zero frame and a previously defined layer
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        // Registering the cell
        collectionView.register(PhotosCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        // Align everything
        collectionView.toAutoLayout()
        // White background
        collectionView.backgroundColor = .white

        collectionView.dataSource = self
        collectionView.delegate = self

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.photos = Storage.photos

        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        // Show navigation bar
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: Layout
extension PhotosViewController {

    // Draw constraints
    private func setupLayout() {
        view.addSubview(collectionView)

        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    // Sets the number of sections
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // в каждой секции 3 ячейки (делим на три и округляем в большую сторону)
        return countOfSections
    }

    // Sets the number of cells in section
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        // if the section is completely full
        case 0...(countOfFullSections-1):
            return maxCountOfItemsInSection
        // if the section is partially full
        case countOfFullSections...(countOfSections-1):
            return photos.count % maxCountOfItemsInSection
        // if the unplanned section
        default:
            return 0
        }
    }

    // Forms a cell of a specific line of a specific section
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
                                                            String(describing: PhotosCollectionViewCell.self),
                                                         for: indexPath) as? PhotosCollectionViewCell {
            cell.photo = photos[indexPath.section * maxCountOfItemsInSection + indexPath.row]
            return cell
        } else { return UICollectionViewCell() }
    }
}

extension PhotosViewController: UICollectionViewDelegate {
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    var offset: CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (collectionView.bounds.width -
                              offset * (CGFloat(maxCountOfItemsInSection)+1)) /
                             CGFloat(maxCountOfItemsInSection)
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return offset
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return offset
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: offset, left: offset, bottom: .zero, right: offset)
    }
}
