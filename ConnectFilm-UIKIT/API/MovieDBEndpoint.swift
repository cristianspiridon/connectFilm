//
//  TheMovieDBAPI.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 02/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Foundation

enum Endpoint {
    case popularMovies(page: Int)

    static let imageBaseURL = URL(string: "http://image.tmdb.org/t/p/")!
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3/")!
    }

    var path: String {
        switch self {
        case let .popularMovies(page):
            return "movie/popular?api_key=\(APIKey)&language=en-US&page=\(page)"
        }
    }

    private var APIKey: String {
        return "2d0abd666109ffaf9829e021e88f5433"
    }
}
