//
//  TrendingView.swift
//  Triflix
//
//  Created by 쌩 on 10/9/24.
//

import UIKit
import SnapKit

final class TrendingView: BaseView {
    let sparkleItem = UIBarButtonItem()
    let magnifyingglassItem = UIBarButtonItem()
    private let scrollView = {
        let sv = UIScrollView()
        sv.isScrollEnabled = true
        return sv
    }()
    private let myView = UIView()
    let mainPosterImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .black
        return iv
    }()
    let mainPosterGenreLabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.numberOfLines = 1
        return lb
    }()
    let playButton  = {
        var configuration = UIButton.Configuration.filled()
        configuration.subtitle = "재생" // text font size : Text Attributes통해 조절
        configuration.image = UIImage(systemName: "play.fill")
        configuration.imagePadding = 10
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .black
        let bt = UIButton(configuration: configuration)
        return bt
    }()
    let favoriteButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.subtitle = "내가 찜한 리스트" // text font size : Text Attributes통해 조절
        configuration.image = UIImage(systemName: "plus")
        configuration.imagePadding = 10
        configuration.baseBackgroundColor = .black
        configuration.baseForegroundColor = .white
        let bt = UIButton(configuration: configuration)
        return bt
    }()
    let trendingMovieLabel = {
        let lb = UILabel()
        lb.text = "지금 뜨는 영화"
        return lb
    }()
    let trendingMovieCV = UICollectionView(frame: .zero, collectionViewLayout: layout())
    let trendingTVLabel = {
        let lb = UILabel()
        lb.text = "지금 뜨는 TV 시리즈"
        return lb
    }()
    let trendingTVCV =  UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 118) // 추후 사이즈 조절
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        return layout
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureUI() {
        self.backgroundColor = .black
        sparkleItem.image = UIImage(systemName: "sparkles.tv")
        sparkleItem.tintColor = .white
        magnifyingglassItem.image = UIImage(systemName: "magnifyingglass")
        magnifyingglassItem.tintColor = .white
        //아래 보기 편하라고 만든 색상들 추후 수정(제거)
        myView.backgroundColor = .clear
    }
    
    override func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(myView)
        [mainPosterImageView, mainPosterGenreLabel, favoriteButton, playButton, trendingMovieLabel,
         trendingMovieCV,
         trendingTVLabel,
         trendingTVCV
        ].forEach {myView.addSubview($0)}
    }
    
    override func setConstraints() {
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        myView.snp.makeConstraints{
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView.snp.width)
        }
        
        mainPosterImageView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.width.equalTo(safeAreaLayoutGuide.snp.width).inset(16)
            $0.height.equalTo(mainPosterImageView.snp.width).multipliedBy(1.3)
        }
        
        mainPosterGenreLabel.snp.makeConstraints {
            $0.bottom.equalTo(playButton.snp.top).offset(-16)
            $0.centerX.equalTo(mainPosterImageView.snp.centerX)
        }
        
        playButton.snp.makeConstraints{
            $0.height.equalTo(32)
            $0.leading.equalTo(mainPosterImageView.snp.leading).inset(16)
            $0.trailing.equalTo(mainPosterImageView.snp.centerX).inset(4)
            $0.bottom.equalTo(mainPosterImageView.snp.bottom).inset(16)
        }
        
        favoriteButton.snp.makeConstraints{
            $0.height.equalTo(32)
            $0.leading.equalTo(mainPosterImageView.snp.centerX).offset(4)
            $0.trailing.equalTo(mainPosterImageView.snp.trailing).inset(16)
            $0.bottom.equalTo(mainPosterImageView.snp.bottom).inset(16)
        }
        
        trendingMovieLabel.snp.makeConstraints{
            $0.top.equalTo(mainPosterImageView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(mainPosterImageView.snp.horizontalEdges).inset(16)
            $0.height.equalTo(20)
        }
        
        trendingMovieCV.snp.makeConstraints{
            $0.top.equalTo(trendingMovieLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        trendingTVLabel.snp.makeConstraints{
            $0.top.equalTo(trendingMovieCV.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(mainPosterImageView.snp.horizontalEdges).inset(16)
            $0.height.equalTo(20)
        }
        
        trendingTVCV.snp.makeConstraints{
            $0.top.equalTo(trendingTVLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(120)
            $0.bottom.equalTo(myView).inset(16) // 아래 여백 필요시 조절 및 제거
        }
    }
}
