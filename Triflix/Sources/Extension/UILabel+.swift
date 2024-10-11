//
//  UILabel+.swift
//  Triflix
//
//  Created by YJ on 10/11/24.
//

import UIKit

extension UILabel {
    func setUI(_ txtColor: UIColor = .white, _ txtAlignment: NSTextAlignment = .left, numOfLines: Int = 1, fontSize: CGFloat, _ fontWeight: UIFont.Weight = .regular) {
        textColor = txtColor
        textAlignment = txtAlignment
        numberOfLines = numOfLines
        font = .systemFont(ofSize: fontSize, weight: fontWeight)
    }
}
