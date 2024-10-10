//
//  DetailViewModel.swift
//  Triflix
//
//  Created by YJ on 10/9/24.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailViewModel: ViewModelProtocol {
    // MARK: Properties
    var disposeBag = DisposeBag()
    
    // MARK: Input / Output
    struct Input {
        let detailData = PublishSubject<MediaDetail>()
        let casts = PublishSubject<String>()
        let creators = PublishSubject<String>()
        let similarData = PublishSubject<[MediaResult.Media]>()
        let xButtonTapped: ControlEvent<Void>
        let collectionViewModelSelected: ControlEvent<MediaResult.Media>
    }
    
    struct Output {
        let detailData: PublishSubject<MediaDetail>
        let casts: PublishSubject<String>
        let creators: PublishSubject<String>
        let similarData: PublishSubject<[MediaResult.Media]>
    }
    
    // MARK: transform
    func transform(input: Input) -> Output {
        // headerViewData
        APIManager.shared.callRequest(api: .detailMovie(id: 889737), type: MediaDetail.self)
            .subscribe(with: self) { owner, result in
                input.detailData.onNext(result)
            } onFailure: { owner, error in
                print("error!: \(error)")
            } onDisposed: { owner in
                print("similarMovie API Disposed")
            }
            .disposed(by: disposeBag)
        
        // castData
        APIManager.shared.callRequest(api: .castMovie(id: 889737), type: CastResult.self)
            .subscribe(with: self) { owner, result in
                // 출연
                let casts = result.actor
                    .map{ $0.name }
                    .joined(separator: ", ")
                input.casts.onNext(casts)
                // 크리에이터
                let creator = result.director
                    .map{ $0.name }
                    .joined(separator: ", ")
                input.creators.onNext(creator)
            } onFailure: { owner, error in
                print("error!: \(error)")
            } onDisposed: { owner in
                print("similarMovie API Disposed")
            }
            .disposed(by: disposeBag)

        
        // similarData
        APIManager.shared.callRequest(api: .similarMovie(id: 1087822), type: MediaResult.self)
            .subscribe(with: self) { owner, result in
                input.similarData.onNext(result.results)
            } onFailure: { owner, error in
                print("error!: \(error)")
            } onDisposed: { owner in
                print("similarMovie API Disposed")
            }
            .disposed(by: disposeBag)
        
        // xButtonTap
        input.xButtonTapped
            .bind(with: self) { owner, _ in
                print("xButtonTapped")
                // 화면 dismiss
            }
            .disposed(by: disposeBag)
        
        // collectionViewModelSelected
        input.collectionViewModelSelected
            .bind(with: self) { owner, result in
                print(">>> \(result.id)")
                // 해당 아이디로 네트워크 재통신 후, 새로운 DetailView로 push
            }
            .disposed(by: disposeBag)
        
        return Output(
            detailData: input.detailData,
            casts: input.casts,
            creators: input.creators,
            similarData: input.similarData)
    }
}
