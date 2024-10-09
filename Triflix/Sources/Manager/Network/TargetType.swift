//
//  TargetType.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        var components = URLComponents(url: try baseURL.asURL().appendingPathComponent(path), resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems
        guard let url = components?.url else { throw URLError(.badURL)}
        var request = try URLRequest(url: url, method: method)
        request.allHTTPHeaderFields = header
        return request
    }
}

struct TrendingResult: Decodable {
    let page: Int
    let results: [Media]
    let total_pages: Int
    let total_results: Int
    
    struct Media: Decodable {
        let id: Int
        let poster_path: String
        let genre_ids: [Int]
    }
}
