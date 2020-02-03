//
//  MoviesDataSource.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 02/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Foundation

final class MoviesDataSource {
    private let network: Network
    private let persistence: RealmService
    private var allPopular: [PopularMoviesResponse]?

    var lastPage: Int {
        return allPopular?.count ?? 0
    }

    init(network: Network = Network(), persistence: RealmService = RealmService.shared) {
        self.network = network
        self.persistence = persistence
    }

    func loadPopularMovies(
        pageIndex: Int,
        completion: @escaping (Result<PopularMoviesResponse, NetworkError>) -> Void
    ) {
        network.fetchPopularMovies(pageIndex: pageIndex) { [weak self] result in
            guard let self = self else {
                completion(.failure(.unknown(nil)))
                return
            }

            if case let Result.success(popularMovies) = result {
                self.allPopular?.append(popularMovies)
                completion(.success(popularMovies))
            }
        }
    }

    func saveToFavourites(model: Movie) {
        let movie = MovieObject(model: model)
        persistence.addToFavourites(movie: movie)
    }

    func getFavourites() -> [Movie] {
        return persistence.getFavourites().map {
            Movie(id: $0.id,
                  title: $0.title,
                  posterPath: $0.posterPath,
                  overview: $0.overview,
                  releaseDate: $0.releaseDate,
                  voteCount: $0.voteCount)
        }
    }
}

private extension Network {
    func fetchPopularMovies(
        pageIndex: Int,
        completion: @escaping (Result<PopularMoviesResponse, NetworkError>) -> Void
    ) {
        fetchModel(endpoint: .popularMovies(page: pageIndex), completion: completion)
    }
}
