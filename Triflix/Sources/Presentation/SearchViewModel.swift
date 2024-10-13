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
    typealias Media = MediaResult.Media
    
    private var searchData = [Media]()
    private var query = ""
    private var pages = 1
    
    let disposeBag = DisposeBag()
    
    struct Input {
        let searchData = PublishSubject<[Media]>()
        let searchButtonClicked: ControlEvent<Void>
        let searchQuery: ControlProperty<String>
        let indexPathInput: PublishSubject<[IndexPath]>
    }
    
    struct Output {
        let searchData: PublishSubject<[Media]>
        let presetnView: BehaviorSubject<Int>
    }
}

extension SearchViewModel {
    func transform(input: Input) -> Output {
//        Observable
//            .combineLatest(input.searchButtonClicked, input.searchQuery)
        let presentView = BehaviorSubject(value: 1)
        let trendInput = BehaviorSubject(value: ())
//        let queryInput = input.searchQuery.share()
        input.searchQuery
            .throttle(.seconds(1), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMap { query in
                self.query = query
                guard !query.isEmpty else {
                    presentView.onNext(1)
                    trendInput.onNext(())
                    return Single<MediaResult>.never()
                }
                return APIManager.shared.callRequest(api: .searchMovie(query: query, page: 1), type: MediaResult.self)
            }
            .bind(with: self) { owner, result in
                owner.pages = 1
                owner.searchData = result.results
                input.searchData.onNext(owner.searchData)
                presentView.onNext(owner.searchData.isEmpty ? 3 : 2)
            }
            .disposed(by: disposeBag)
        
        trendInput
            .flatMap {
                return APIManager.shared.callRequest(api: .trendingMovie, type: MediaResult.self)
            }
            .bind(with: self) { owner, result in
                owner.searchData = result.results
                input.searchData.onNext(owner.searchData)
            }
            .disposed(by: disposeBag)

        input.indexPathInput
            .bind(with: self) { owner, indexPaths in
                for indexPath in indexPaths {
                    if indexPath.item == owner.searchData.count - 4 {
                        fetchMedia(page: owner.pages)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        func fetchMedia(page: Int) {
            APIManager.shared.callRequest(api: .searchMovie(query: query, page: page), type: MediaResult.self)
                .asObservable()
                .bind(with: self) { owner, result in
                    owner.pages = result.page + 1
                    owner.searchData.append(contentsOf: result.results)
                    input.searchData.onNext(owner.searchData)
                }
                .disposed(by: disposeBag)
        }
        
        return Output(searchData: input.searchData, presetnView: presentView)
    }
}
