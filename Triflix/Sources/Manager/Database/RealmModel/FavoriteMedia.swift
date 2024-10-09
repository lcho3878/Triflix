//
//  FavoriteMedia.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation
import RealmSwift

final class FavoriteMedia: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var mediaID: Int
    @Persisted var title: String
    @Persisted var posterPath: String
    
    convenience init(mediaID: Int, title: String, posterPath: String) {
        self.init()
        self.mediaID = mediaID
        self.title = title
        self.posterPath = posterPath
    }
}
