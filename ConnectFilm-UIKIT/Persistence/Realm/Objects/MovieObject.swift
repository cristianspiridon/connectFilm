//
//  MovieObject.swift
//  ConnectFilm-UIKIT
//
//  Created by The Spiridon's on 03/02/2020.
//  Copyright © 2020 The Spiridon's. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class MovieObject: Object {
    dynamic var id: Int = 0
    dynamic var title: String = ""
    dynamic var posterPath: String?
    dynamic var overview: String?
    dynamic var releaseDate: DateFormat?

    override static func primaryKey() -> String {
        return "id"
    }

    convenience init(model: Movie) {
        self.init()

        id = model.id
        title = model.title
        posterPath = model.posterPath
        overview = model.overview
        releaseDate = model.releaseDate
    }
}
