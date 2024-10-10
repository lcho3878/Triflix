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
    private let disposeBag = DisposeBag()
    let viewModel = DetailViewModel()
    
    // MARK: View Life Cycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureCollectionView()
        bind()
    }
    
    // MARK: Functions
    private func configureCollectionView() {
        detailView.collectionView.register(PosterImageCell.self, forCellWithReuseIdentifier: PosterImageCell.id)
        detailView.collectionView.showsVerticalScrollIndicator = false
        detailView.collectionView.isScrollEnabled = false
    }
    
    private func configureNavigation() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }
    
    private func bind() {
        let input = DetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        // headerViewData
        output.detailData
            .bind(with: self) { owner, detailData in
                let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(detailData.backdropPath)")
                owner.detailView.posterImageView.kf.setImage(with: imageURL)
                owner.detailView.titleLabel.text = detailData.title
                owner.detailView.voteAverageLabel.text = String(format: "%.1f", detailData.voteAverage)
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
            .bind(to: detailView.collectionView.rx.items(cellIdentifier: PosterImageCell.id, cellType: PosterImageCell.self)) { (row, element, cell) in
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
        
        // modelSelected
        detailView.collectionView.rx.modelSelected(MediaResult.Media.self)
            .bind(with: self) { owner, result in
                let detailVC = DetailViewController()
                detailVC.viewModel.type = owner.viewModel.type
                detailVC.viewModel.id = result.id
                owner.navigationController?.pushViewController(detailVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        // xButton
        detailView.xButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        
        // realm 저장
        Observable.combineLatest(detailView.saveButton.rx.tap, output.detailData)
            .bind(with: self) { owner, value in
                MediaRepository.shared.addMedia(media: value.1, image: owner.detailView.posterImageView.image) {
                    let alert = AlertViewController()
                    alert.alertView.titleLabel.text = "이미 저장된 미디어에요 :)"
                    alert.modalPresentationStyle = .overFullScreen
                    owner.present(alert, animated: true)
                } success: {
                    let alert = AlertViewController()
                    alert.alertView.titleLabel.text = "미디어를 저장했어요 :)"
                    alert.modalPresentationStyle = .overFullScreen
                    owner.present(alert, animated: true)
                }
            }
            .disposed(by: disposeBag)
    }
}
