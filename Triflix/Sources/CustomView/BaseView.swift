//
//  BaseView.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation
import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {}
    
    func addSubviews() {}
    
    func setConstraints() {}
}
