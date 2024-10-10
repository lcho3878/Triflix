//
//  SearchViewModel.swift
//  Triflix
//
//  Created by YJ on 10/10/24.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel: ViewModelProtocol {
    var disposeBag = DisposeBag()
    
    struct Input {
        let searchData = PublishSubject<[MediaResult.Media]>()
    }
    
    struct Output {
        let searchData: PublishSubject<[MediaResult.Media]>
    }
    
    func transform(input: Input) -> Output {
        APIManager.shared.callRequest(api: .searchMovie(query: "어벤져스"), type: MediaResult.self)
            .subscribe(with: self) { owner, result in
                input.searchData.onNext(result.results)
            } onFailure: { owner, error in
                print("error: \(error)")
            } onDisposed: { owner in
                print("searchMovieAPI Disposed")
            }
            .disposed(by: disposeBag)
        
        return Output(searchData: input.searchData)
    }
}
