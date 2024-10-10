//
//  PosterImageCell.swift
//  Triflix
//
//  Created by YJ on 10/9/24.
//

import UIKit
import SnapKit

final class PosterImageCell: UICollectionViewCell {
    let posterImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    func addSubviews() {
        contentView.addSubview(posterImageView)
    }
    
    func setConstraints() {
        posterImageView.snp.makeConstraints {
            $0.edges.equalTo(contentView.safeAreaLayoutGuide).inset(2)
        }
    }
    
    func configureUI() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
    }
}
