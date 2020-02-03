//
//  MovieDetailsViewController.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 03/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Nuke
import UIKit

class MovieDetailsViewController: UIViewController, Storyboarded {
    @IBOutlet var posterImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseYear: UILabel!
    @IBOutlet var overviewText: UILabel!
    @IBOutlet var addToFavButton: UIButton!

    var model: Movie?
    weak var dataStore: MoviesDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_: Bool) {
        setTextDetails()
        setImage()
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

    private func setTextDetails() {
        guard let model = model else { return }
        titleLabel.text = model.title
        overviewText.text = model.overview
        let year = Calendar.current.component(.year, from: model.releaseDate!.date)
        releaseYear.text = "\(year)"
    }

    @IBAction func addToFavourites(_: Any) {
        guard let dataStore = dataStore, let model = model else { return }
        dataStore.saveToFavourites(model: model)

        addToFavButton.setTitle("Added to Favourites", for: .normal)
        addToFavButton.isEnabled = false
    }
}
