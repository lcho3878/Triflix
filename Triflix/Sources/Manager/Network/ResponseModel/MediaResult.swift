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
    
    struct Media: Decodable, MediaType {
        let id: Int
        let title: String
        let poster_path: String?
        let genre_ids: [Int]
        var genres: String {
                var genres: [String] = []
                for item in genre_ids {
                    switch item {
                    case 28:
                        genres.append("#Action")
                    case 12:
                        genres.append("#Adventure")
                    case 16:
                        genres.append("#Animation")
                    case 35:
                        genres.append("#Comedy")
                    case 80:
                        genres.append("#Crime")
                    case 99:
                        genres.append("#Documentary")
                    case 18:
                        genres.append("#Drama")
                    case 10751:
                        genres.append("#Family")
                    case 14:
                        genres.append("#Fantasy")
                    case 36:
                        genres.append("#History")
                    case 27:
                        genres.append("#Horror")
                    case 10402:
                        genres.append("#Music")
                    case 9648:
                        genres.append("#Mystery")
                    case 10749:
                        genres.append("#Romance")
                    case 878:
                        genres.append("#Science Fiction")
                    case 10770:
                        genres.append("#TV Movie")
                    case 53:
                        genres.append("#Thriller")
                    case 10752:
                        genres.append("#War")
                    case 37:
                        genres.append("#Western")
                    default: break
                    }
                }
                return genres.joined(separator: " ")
            }
        enum CodingKeys: String, CodingKey {
            case id
            case title
            case poster_path
            case genre_ids
            case name
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            poster_path = try? container.decode(String?.self, forKey: .poster_path)
            genre_ids = try container.decode([Int].self, forKey: .genre_ids)
            
            if let name = try? container.decode(String.self, forKey: .name) {
                title = name
            } else {
                title = try container.decode(String.self, forKey: .title)
            }
        }
    }
}
