//
//  MoviesListViewModel.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 03/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Foundation

class MoviesListViewModel {
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

    func loadNextPage() {
        guard let dataStore = dataStore else { return }
        viewController?.setActivityIndicator(isVisible: true)
        dataStore.loadPopularMovies(pageIndex: dataStore.lastPage + 1) { [weak self] result in
            switch result {
            case let .success(popularMovies):
                self?.movies += popularMovies.results
                DispatchQueue.main.async {
                    self?.viewController?.reloadData()
                }
            case let .failure(error):
                self?.viewController?.showError(error: error.localizedDescription)
            }
        }
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
