//
//  DetailViewController.swift
//  Triflix
//
//  Created by 이찬호 on 10/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class DetailViewController: UIViewController {
    // MARK: Properties
    private let detailView = DetailView()
    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: View Life Cycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        bind()
    }
    
    // MARK: Functions
    private func configureCollectionView() {
        detailView.collectionView.register(SimilarCell.self, forCellWithReuseIdentifier: SimilarCell.id)
        detailView.collectionView.showsVerticalScrollIndicator = false
        detailView.collectionView.isScrollEnabled = false
    }
    
    private func bind() {
        let input = DetailViewModel.Input(
            xButtonTapped: detailView.xButton.rx.tap,
            collectionViewModelSelected: detailView.collectionView.rx.modelSelected(MediaResult.Media.self))
        let output = viewModel.transform(input: input)
        
        var media: MediaDetail?
        
        // headerViewData
        output.detailData
            .bind(with: self) { owner, detailData in
                let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(detailData.backdrop_path)")
                owner.detailView.posterImageView.kf.setImage(with: imageURL)
                owner.detailView.titleLabel.text = detailData.title
                owner.detailView.voteAverageLabel.text = String(format: "%.1f", detailData.vote_average)
                owner.detailView.descriptionLabel.text = detailData.overview
            }
            .disposed(by: disposeBag)
        
        // casts & creators
        Observable.combineLatest(output.casts, output.creators)
            .bind(with: self) { owner, tuple in
                let (casts, creators) = tuple
                owner.detailView.castLabel.text = "출연: \(casts)\n크리에이터: \(creators)"
            }
            .disposed(by: disposeBag)
        
        // similarData
        output.similarData
            .bind(to: detailView.collectionView.rx.items(cellIdentifier: SimilarCell.id, cellType: SimilarCell.self)) { (row, element, cell) in
                if let imageData = element.poster_path {
                    let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(imageData)")
                    cell.posterImageView.kf.setImage(with: imageURL, options: [.transition(.fade(1.2))])
                    cell.posterImageView.kf.indicatorType = .activity
                } else {
                    cell.posterImageView.image = UIImage(systemName: "movieclapper")
                    cell.posterImageView.tintColor = .white
                    cell.posterImageView.contentMode = .scaleAspectFit
                }
            }
            .disposed(by: disposeBag)  
        
        // realm 저장
        Observable.combineLatest(detailView.saveButton.rx.tap, output.detailData)
            .bind(with: self) { owner, value in
                MediaRepository.shared.addMedia(media: value.1, image: owner.detailView.posterImageView.image)
            }
            .disposed(by: disposeBag)
    }
}
