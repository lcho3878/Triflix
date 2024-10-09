//
//  MediaDetail.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation

struct MediaDetail: Decodable {
    let backdrop_path: String
    let poster_path: String
    let title: String
    let overview: String
    let vote_average: Double
}
