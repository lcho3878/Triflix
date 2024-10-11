//
//  UICollectionView+.swift
//  Triflix
//
//  Created by YJ on 10/11/24.
//

import UIKit

extension UICollectionView {
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 10
        layout.itemSize = CGSize(width: width / 3, height: 175)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }
}
