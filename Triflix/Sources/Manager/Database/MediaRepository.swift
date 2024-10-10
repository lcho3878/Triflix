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
    
    func addMedia(media: MediaType, image: UIImage?, fail: () -> Void, success: () -> Void) {
        guard isNotExist(media) else {
            fail()
            return
        }
        PhotoManager.shared.saveImage(image: image, filename: "\(media.id)")
        let object = FavoriteMedia(mediaID: media.id, title: media.title, posterPath: "")
        try! realm.write {
            realm.add(object)
        }
        success()
    }
    
    func removeMedia(media: FavoriteMedia) {
        PhotoManager.shared.removeImage(filename: "\(media.mediaID)")
        try! realm.write {
            realm.delete(media)
        }
    }
    
    func readAllMedia() -> Results<FavoriteMedia> {
        return realm.objects(FavoriteMedia.self)
    }
    
    func isNotExist(_ media: MediaType) -> Bool {
        return realm.objects(FavoriteMedia.self).filter { $0.mediaID == media.id }.isEmpty
    }
}
