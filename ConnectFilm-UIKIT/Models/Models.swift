//
//  Models.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 02/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Foundation

/// A movie list JSON response
struct PopularMoviesResponse: Codable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

/// A single movie block
struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String?
    let releaseDate: DateFormat?
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
        case voteCount = "vote_count"
    }
}

/// Data format parser
struct DateFormat: Codable {
    let date: Date

    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // "2017-10-25"
        return formatter
    }()

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        guard let date = DateFormat.formatter.date(from: rawValue) else {
            throw NetworkError.parsingError("\(rawValue) doesn't match the format \(DateFormat.formatter.dateFormat ?? "") ")
        }
        self.date = date
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(DateFormat.formatter.string(from: date))
    }
}
