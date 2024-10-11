//
//  UIView+.swift
//  Triflix
//
//  Created by YJ on 10/11/24.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
