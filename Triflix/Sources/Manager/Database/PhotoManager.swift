//
//  PhotoManager.swift
//  Triflix
//
//  Created by 이찬호 on 10/10/24.
//

import UIKit

final class PhotoManager {
    static let shared = PhotoManager()
    
    private let fileManager = FileManager.default
    
    private init() {}
    
    func saveImage(image: UIImage?, filename: String) {
        guard let image else { return }
        guard let documentDirectory = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        guard let data = image.jpegData(compressionQuality: 0.5) else { return }
        do {
            try data.write(to: fileURL)
        } catch {
            print("Image Save Error: \(error)")
        }
    }
    
    func loadImage(filename: String) -> UIImage? {
        guard let documentDirectory = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return nil }
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        if fileManager.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)
        } else {
            return nil
        }
    }
    
    func removeImage(filename: String) {
        guard let documentDirectory = fileManager.urls(
            for: .documentDirectory,
            in: .userDomainMask).first else { return }
        let fileURL = documentDirectory.appendingPathComponent("\(filename).jpg")
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(atPath: fileURL.path)
            } catch {
                print("File Remove Error: \(error)")
            }
        } else {
            print("File doesn't exist")
        }
    }
}
