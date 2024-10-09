//
//  DetailView.swift
//  Triflix
//
//  Created by YJ on 10/9/24.
//

import UIKit
import SnapKit

final class DetailView: BaseView {
    let posterImageView = UIImageView()
    let monitorButton = UIButton()
    let xButton = UIButton()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let headerView = UIView()
    let titleLabel = UILabel()
    let voteAverageLabel = UILabel()
    let playButton = UIButton(configuration: .plain())
    let saveButton = UIButton(configuration: .plain())
    let descriptionLabel = UILabel()
    let castLabel = UILabel()
    private let similarTextLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    override func addSubviews() {
        addSubviews([posterImageView, monitorButton, xButton, scrollView])
        scrollView.addSubview(contentView)
        contentView.addSubviews([headerView, collectionView])
        headerView.addSubviews([titleLabel, voteAverageLabel, playButton, saveButton, descriptionLabel, castLabel, similarTextLabel])
    }
    
    override func setConstraints() {
        let safeArea = safeAreaLayoutGuide
        let scrollViewFrame = scrollView.frameLayoutGuide
        let scrollViewContent = scrollView.contentLayoutGuide
        
        posterImageView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(220)
        }
        
        xButton.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(8)
            $0.trailing.equalTo(posterImageView.snp.trailing).inset(8)
            $0.width.height.equalTo(30)
        }
        
        monitorButton.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(8)
            $0.trailing.equalTo(xButton.snp.leading).offset(-8)
            $0.width.height.equalTo(30)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.verticalEdges.equalTo(scrollViewContent.snp.verticalEdges)
            $0.horizontalEdges.equalTo(scrollViewFrame.snp.horizontalEdges)
        }
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top)
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            $0.bottom.equalTo(similarTextLabel.snp.bottom)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.top).offset(8)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
        }
        
        voteAverageLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
        }
        
        playButton.snp.makeConstraints {
            $0.top.equalTo(voteAverageLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
            $0.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(playButton.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
            $0.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(saveButton.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
        }
        
        castLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
        }
        
        similarTextLabel.snp.makeConstraints {
            $0.top.equalTo(castLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            $0.height.equalTo(1230)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    override func configureUI() {
        xButton.backgroundColor = .red
        monitorButton.backgroundColor = .orange
        collectionView.backgroundColor = .clear
        
        posterImageView.contentMode = .scaleToFill
        posterImageView.clipsToBounds = true
        
        playButton.backgroundColor = .white
        playButton.configurationUpdateHandler = { btn in
            btn.configuration?.title = "재생"
            btn.tintColor = .black
            btn.configuration?.image = UIImage(systemName: "play.fill")
            btn.configuration?.imagePadding = 10
        }
        playButton.layer.cornerRadius = 10
        
        saveButton.backgroundColor = .darkGray
        saveButton.configurationUpdateHandler = { btn in
            btn.configuration?.title = "저장"
            btn.tintColor = .white
            btn.configuration?.image = UIImage(systemName: "square.and.arrow.down")
            btn.configuration?.imagePadding = 10
        }
        saveButton.layer.cornerRadius = 10
        
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .left
        castLabel.numberOfLines = 0
        castLabel.textAlignment = .left
        similarTextLabel.numberOfLines = 1
        similarTextLabel.textAlignment = .left
        
        // 임시
        castLabel.text = "출연 \("크리에이터출연 크리에이터출연")\n\("크리에이터출연 크리에이터출연 크리에이터")"
        similarTextLabel.text = "비슷한 콘텐츠"
        titleLabel.textColor = .white
        voteAverageLabel.textColor = .white
        descriptionLabel.textColor = .white
        castLabel.textColor = .white
        similarTextLabel.textColor = .white
    }
    
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

// MARK: UIView+
extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
