//
//  MediaRepository.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import UIKit
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
    
    func addMedia(media: MediaDetail, image: UIImage?) {
        PhotoManager.shared.saveImage(image: image, filename: "\(media.id)")
        let object = FavoriteMedia(mediaID: media.id, title: media.title, posterPath: media.poster_path)
        try! realm.write {
            realm.add(object)
        }
    }
    
    func removeMedia(media: FavoriteMedia) {
        PhotoManager.shared.removeImage(filename: "\(media.id)")
        try! realm.write {
            realm.delete(media)
        }
    }
    
    func readAllMedia() -> Results<FavoriteMedia> {
        return realm.objects(FavoriteMedia.self)
    }
}
