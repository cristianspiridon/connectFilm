//
//  RealmService.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 03/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    public func safeWrite(_ block: () throws -> Void) throws {
        if isInWriteTransaction {
            try block()
        } else {
            try write(block)
        }
    }
}

class RealmService {
    private init() {}
    static let shared = RealmService()

    var moviesProvider = RealmProvider.movies

    func addToFavourites(movie: MovieObject) {
        moviesProvider.create(movie)
        print("added to persistence ", movie)
    }

    func getFavourites() -> [MovieObject] {
        return Array(moviesProvider.realm.objects(MovieObject.self))
    }

    func deleteAll() {
        moviesProvider.deleteAll()
    }
}
