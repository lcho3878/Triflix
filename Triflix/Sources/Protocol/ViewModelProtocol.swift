//
//  ViewModelProtocol.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation
import RxSwift

protocol ViewModelProtocol: AnyObject {
    var disposeBag: DisposeBag { get }
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}
