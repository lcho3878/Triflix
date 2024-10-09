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
    var disposeBag = DisposeBag()
    
    struct Input {
        let detailData = PublishSubject<MediaDetail>()
        let similarData = PublishSubject<[MediaResult.Media]>()
    }
    
    struct Output {
        let detailData: PublishSubject<MediaDetail>
        let similarData: PublishSubject<[MediaResult.Media]>
    }
    
    func transform(input: Input) -> Output {
        APIManager.shared.callRequest(api: .detailMovie(id: 889737), type: MediaDetail.self)
            .subscribe(with: self) { owner, result in
                input.detailData.onNext(result)
                dump(result)
            } onFailure: { owner, error in
                print("error!: \(error)")
            } onDisposed: { owner in
                print("similarMovie API Disposed")
            }
            .disposed(by: disposeBag)
        
        APIManager.shared.callRequest(api: .similarMovie(id: 1087822), type: MediaResult.self)
            .subscribe(with: self) { owner, result in
                input.similarData.onNext(result.results)
            } onFailure: { owner, error in
                print("error!: \(error)")
            } onDisposed: { owner in
                print("similarMovie API Disposed")
            }
            .disposed(by: disposeBag)
        
        return Output(
            detailData: input.detailData,
            similarData: input.similarData
        )
    }
}
