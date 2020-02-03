//
//  MovieTableViewCell.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 02/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Nuke
import UIKit

class MovieCell: UITableViewCell {
    static let identifier: String = "MovieCell"
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var releaseDate: UILabel!
    @IBOutlet var overviewText: UITextView!
    @IBOutlet var posterImage: UIImageView!

    var model: Movie? {
        didSet {
            setTextDetails()
            setImage()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    private func setTextDetails() {
        guard let model = model else { return }
        titleLabel.text = model.title
        overviewText.text = model.overview
        let year = Calendar.current.component(.year, from: model.releaseDate!.date)
        releaseDate.text = "\(year)"
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
