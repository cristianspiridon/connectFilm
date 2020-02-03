//
//  FavouriteMoviesViewController.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 03/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import UIKit

class FavouriteMoviesViewController: UIViewController, Storyboarded {
    var model: FavouriteMoviesViewModel!
    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(MovieCollection.nib, forCellWithReuseIdentifier: MovieCollection.identifier)
    }

    override func viewDidAppear(_: Bool) {
        model.loadFavourites()
        collectionView.reloadData()
    }
}

extension FavouriteMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 3.0
        return CGSize(width: width, height: width * 4 / 3 + 50)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return model.moviesCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollection = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollection", for: indexPath) as! MovieCollection
        cell.model = model.movie(at: indexPath.row)
        return cell
    }
}
