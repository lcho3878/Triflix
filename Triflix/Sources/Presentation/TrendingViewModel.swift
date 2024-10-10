//
//  TrendingViewModel.swift
//  Triflix
//
//  Created by 쌩 on 10/9/24.
//

import Foundation
import RxSwift

final class TrendingViewModel: ViewModelProtocol {
    // MARK:  Properties
    let disposeBag = DisposeBag()
    
    // MARK:  Input / Output
    struct Input {
        let viewDidLoadTrigger: PublishSubject<Void>
    }
    
    struct Output {
        let movieOutput: PublishSubject<[MediaResult.Media]>
        let TVOutput: PublishSubject<[MediaResult.Media]>
    }
    
    // MARK:  Transform
    func transform(input: Input) -> Output {
        let movieOutput = PublishSubject<[MediaResult.Media]>()
        let tvOutput = PublishSubject<[MediaResult.Media]>()
        
        input.viewDidLoadTrigger.bind(with: self) { owner, _ in
            APIManager.shared.callRequest(api: .trendingMovie, type: MediaResult.self).subscribe(with: self) { owner, result in
                movieOutput.onNext(result.results)
            } onFailure: { owner, error in
                print("error!: \(error)")
            } onDisposed: { owner in
                print("similarMovie API Disposed")
            }
            .disposed(by: owner.disposeBag)
        }.disposed(by: disposeBag)
        
        input.viewDidLoadTrigger.bind(with: self) { owner, _ in
            APIManager.shared.callRequest(api: .trendingTV, type: MediaResult.self).subscribe(with: self) { owner, result in
                tvOutput.onNext(result.results)
            } onFailure: { owner, error in
                print(">>> error!: \(error)")
            } onDisposed: { owner in
                print("similarMovie API Disposed")
            }
            .disposed(by: owner.disposeBag)
        }.disposed(by: disposeBag)
        
        return Output(movieOutput: movieOutput, TVOutput: tvOutput)
    }
    
}

