//
//  MediaDetail.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation

struct MediaDetail: Decodable, MediaType {
    let id: Int
    let backdropPath: String
    let posterPath: String
    let title: String
    let overview: String
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case title
        case overview
        case voteAverage = "vote_average"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        backdropPath = try container.decode(String.self, forKey: .backdropPath)
        posterPath = try container.decode(String.self, forKey: .posterPath)
        overview = try container.decode(String.self, forKey: .overview)
        voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        
        if let name = try? container.decode(String.self, forKey: .name) {
            title = name
        } else {
            title = try container.decode(String.self, forKey: .title)
        }
    }
}
