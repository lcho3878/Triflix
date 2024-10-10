//
//  Router.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation
import Alamofire

enum Router {
    case trendingMovie
    case trendingTV
    case searchMovie(query: String, page: Int)
    case searchTV(query: String, page: Int)
    case similarMovie(id: Int)
    case similarTV(id: Int)
    case castMovie(id: Int)
    case castTV(id: Int)
    case detailMovie(id: Int)
    case detailTV(id: Int)
}

extension Router: TargetType {
    var baseURL: String {
        return "https://api.themoviedb.org/3"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .trendingMovie: return "/trending/movie/day"
        case .trendingTV: return "/trending/tv/day"
        case .searchMovie: return "/search/movie"
        case .searchTV: return "/search/tv"
        case .similarMovie(let id): return "/movie/\(id)/similar"
        case .similarTV(let id): return "/tv/\(id)/similar"
        case .castMovie(let id): return "/movie/\(id)/credits"
        case .castTV(let id): return "/tv/\(id)/credits"
        case .detailMovie(let id): return "/movie/\(id)"
        case .detailTV(let id): return "/tv/\(id)"
        }
    }
    
    var header: [String : String] {
        return [
            "accept": "application/json",
            "Authorization": Key.key
        ]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchMovie(let query, let page),
                .searchTV(let query, let page):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "language", value: "ko-KR"),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        default :
            return  [
                URLQueryItem(name: "language", value: "ko-KR")
            ]
        }
    }
}
