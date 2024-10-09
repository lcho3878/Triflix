//
//  MediaRepository.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation
import RealmSwift

final class MediaRepository {
    static let shared = MediaRepository()
    
    private let realm = try! Realm()
    
    private init() {}
}

extension MediaRepository {
    func printFileURL() {
        print(realm.configuration.fileURL!)
    }
    
    func addMedia(_ media: MediaDetail) {
        let object = FavoriteMedia(mediaID: media.id, title: media.title, posterPath: media.poster_path)
        try! realm.write {
            realm.add(object)
        }
    }
    
    func removeMedia(_ media: FavoriteMedia) {
        try! realm.write {
            realm.delete(media)
        }
    }
    
    func readAllMedia() -> Results<FavoriteMedia> {
        return realm.objects(FavoriteMedia.self)
    }
}
