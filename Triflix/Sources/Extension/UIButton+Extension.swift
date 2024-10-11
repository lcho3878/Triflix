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
    }
    
    func setConfigUI(bgColor: UIColor, tintColor: UIColor, title: String, image: String) {
        backgroundColor = bgColor
        configurationUpdateHandler = { btn in
            btn.configuration?.attributedTitle = AttributedString(title, attributes: AttributeContainer([.font: UIFont.systemFont(ofSize: 15)]))
            btn.tintColor = tintColor
            btn.configuration?.image = UIImage(systemName: image)?.applyingSymbolConfiguration(.init(pointSize: 13))
            btn.configuration?.imagePadding = 10
        }
        layer.cornerRadius = 5
    }
}
