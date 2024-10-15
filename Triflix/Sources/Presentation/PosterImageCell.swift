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
    
    func configureData(posterPath: String?) {
        if let imageData = posterPath {
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(imageData)")
            posterImageView.kf.setImage(with: imageURL, options: [.transition(.fade(0.7))])
            posterImageView.kf.indicatorType = .activity
        } else {
            posterImageView.image = UIImage(systemName: "movieclapper")
            posterImageView.tintColor = .white
            posterImageView.contentMode = .scaleAspectFit
        }
    }
}
