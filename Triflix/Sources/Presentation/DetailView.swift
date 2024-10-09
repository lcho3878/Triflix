//
//  DetailView.swift
//  Triflix
//
//  Created by YJ on 10/9/24.
//

import UIKit
import SnapKit

final class DetailView: BaseView {
    // MARK: UI
    let posterImageView = UIImageView()
    let mirroringButton = UIButton()
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
    
    // MARK: Functions
    override func addSubviews() {
        addSubviews([posterImageView, mirroringButton, xButton, scrollView])
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
        
        mirroringButton.snp.makeConstraints {
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
            $0.top.equalTo(voteAverageLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
            $0.height.equalTo(33)
        }
        
        saveButton.snp.makeConstraints {
            $0.top.equalTo(playButton.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
            $0.height.equalTo(33)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(saveButton.snp.bottom).offset(15)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
        }
        
        castLabel.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
        }
        
        similarTextLabel.snp.makeConstraints {
            $0.top.equalTo(castLabel.snp.bottom).offset(15)
            $0.horizontalEdges.equalTo(headerView.snp.horizontalEdges).inset(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(contentView.snp.horizontalEdges)
            $0.height.equalTo(1230)
            $0.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    override func configureUI() {
        collectionView.backgroundColor = .clear
        
        posterImageView.contentMode = .scaleToFill
        posterImageView.clipsToBounds = true
        mirroringButton.setImage(UIImage(systemName: "sparkles.tv"), for: .normal)
        mirroringButton.tintColor = .white
        xButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        xButton.tintColor = .white
        
        playButton.setConfigUI(bgColor: .white, tintColor: .black, title: "재생", image: "play.fill")
        saveButton.setConfigUI(bgColor: .saveButton, tintColor: .white, title: "저장", image: "square.and.arrow.down")
        
        titleLabel.setUI(fontSize: 18, .black)
        voteAverageLabel.setUI(fontSize: 13, .semibold)
        descriptionLabel.setUI(numOfLines: 0, fontSize: 15, .regular)
        castLabel.setUI(.lightGray, numOfLines: 2, fontSize: 14, .semibold)
        similarTextLabel.setUI(fontSize: 16, .bold)
        
        similarTextLabel.text = "비슷한 콘텐츠"
        
        // 임시
        castLabel.text = "출연: 톰 홀랜드 마이클 키튼 로버트 다우니 주니어\n크리에이터: Kirk R. Thatcher"
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

// MARK: UILabel+
extension UILabel {
    func setUI(_ txtColor: UIColor = .white, _ txtAlignment: NSTextAlignment = .left, numOfLines: Int = 1, fontSize: CGFloat, _ fontWeight: UIFont.Weight = .regular) {
        textColor = txtColor
        textAlignment = txtAlignment
        numberOfLines = numOfLines
        font = .systemFont(ofSize: fontSize, weight: fontWeight)
    }
}

// MARK: UIButton+
extension UIButton {
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
