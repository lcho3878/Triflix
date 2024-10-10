//
//  UIButton+Extension.swift
//  Triflix
//
//  Created by 쌩 on 10/10/24.
//

import UIKit

extension UIButton {
    func topProfileUI(imageName: String) {
            setImage(UIImage(named: imageName), for: .normal)
            layer.borderWidth = 2
            layer.cornerRadius = 20
            clipsToBounds = true
        }
}
