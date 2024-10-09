//
//  MediaResult.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation

struct MediaResult: Decodable {
    let page: Int
    let results: [Media]
    let total_pages: Int
    let total_results: Int
    
    struct Media: Decodable {
        let id: Int
        let poster_path: String?
        let genre_ids: [Int]
    }
}
