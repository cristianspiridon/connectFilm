//
//  MovieCollection.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 03/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Nuke
import UIKit

class MovieCollection: UICollectionViewCell {
    static let identifier: String = "MovieCollection"
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }

    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var title: UILabel!

    var model: Movie? {
        didSet {
            setTextDetails()
            setImage()
        }
    }

    private func setTextDetails() {
        guard let model = model else { return }
        title.text = model.title
    }

    private func setImage() {
        guard let posterPath = model?.posterPath else { return }
        let posterURL = Endpoint.imageBaseURL
            .appendingPathComponent("w780")
            .appendingPathComponent(posterPath)

        Nuke.loadImage(with: posterURL,
                       options: ImageLoadingOptions(transition: .fadeIn(duration: 0.33)),
                       into: posterImage)
    }
}
