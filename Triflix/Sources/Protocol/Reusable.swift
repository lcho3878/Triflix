//
//  Reusable.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import UIKit

protocol Reusable: AnyObject {
    static var id: String { get }
}

extension UIView: Reusable {
    static var id: String {
        return String(describing: self)
    }
}
