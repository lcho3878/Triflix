//
//  APIManager.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation
import Alamofire
import RxSwift

final class APIManager {
    
    static let shared = APIManager()
    
    private init() {}
    
    func callRequest<T: Decodable>(api: Router, type: T.Type) -> Single<T> {
        return Single.create { single -> Disposable in
            do {
                let request = try api.asURLRequest()
                AF.request(request)
                    .validate(statusCode: 200..<300)
                    .responseDecodable(of: T.self) { response in
                        switch response.result {
                        case .success(let v):
                            single(.success(v))
                        case .failure(let e):
                            single(.failure(e))
                        }
                    }
            }
            catch {
                print("catching Error: \(error)")
            }
            return Disposables.create()
        }
    }
    
    func testReqeust<T: Decodable>(api: Router, type: T.Type) {
        do {
            let request = try api.asURLRequest()
            AF.request(request)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let v): dump(v)
                    case .failure(let e): print("error: \(e.localizedDescription)")
                    }
                }
        }
        catch {
            print("catching Error: \(error)")
        }
    }
}
