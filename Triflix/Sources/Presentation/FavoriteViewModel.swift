//
//  FavoriteViewModel.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation
import RxSwift
import RealmSwift

final class FavoriteViewModel: ViewModelProtocol {
    let disposeBag = DisposeBag()
    
    private var medias: [FavoriteMedia] = []
    
    struct Input {
        let viewDidLoadTrigger: PublishSubject<Void>
        let deleteIndex: PublishSubject<Int>
    }
    struct Output {
        let mediaOutput: PublishSubject<[FavoriteMedia]>
    }
}

extension FavoriteViewModel {
    func transform(input: Input) -> Output {
        let mediaOutput = PublishSubject<[FavoriteMedia]>()
        input.viewDidLoadTrigger
            .bind(with: self) { owner, _ in
                let objects = DataManager.shared.readAllMedia()
                owner.medias = Array(objects)
                mediaOutput.onNext(owner.medias)
            }
            .disposed(by: disposeBag)
        
        input.deleteIndex
            .bind(with: self) { owner, index in
                let object = owner.medias[index]
                DataManager.shared.removeMedia(object)
                input.viewDidLoadTrigger.onNext(())
            }
            .disposed(by: disposeBag)
        return Output(mediaOutput: mediaOutput)
    }
}
