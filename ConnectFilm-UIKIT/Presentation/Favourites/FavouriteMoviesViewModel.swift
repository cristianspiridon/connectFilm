//
//  FavouriteMoviesViewModel.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 03/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Foundation

class FavouriteMoviesViewModel {
    weak var viewController: MoviesViewControllerDisplayLogic?
    private let dataStore: MoviesDataSource?
    var onSelectMovie: ((Movie) -> Void)?

    private var movies = [Movie]()

    var moviesCount: Int {
        return movies.count
    }

    init(dataStore: MoviesDataSource) {
        self.dataStore = dataStore
    }

    func loadFavourites() {
        guard let dataStore = dataStore else { return }
        movies = dataStore.getFavourites()
    }

    func movie(at index: Int) -> Movie? {
        if movies.indices.contains(index) {
            return movies[index]
        }
        return nil
    }

    func selectMovie(at index: Int) {
        guard let movie = movie(at: index) else { return }
        onSelectMovie?(movie)
    }
}
