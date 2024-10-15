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

final class DetailViewController: BaseViewController {
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
}

// MARK: configureCollectionView & configureNavigation
extension DetailViewController {
    private func configureCollectionView() {
        detailView.collectionView.register(PosterImageCell.self, forCellWithReuseIdentifier: PosterImageCell.id)
        detailView.collectionView.showsVerticalScrollIndicator = false
        detailView.collectionView.isScrollEnabled = false
    }
    
    private func configureNavigation() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
    }
}

// MARK: bind
extension DetailViewController {
    private func bind() {
        let input = DetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        // headerViewData
        output.detailData
            .bind(with: self) { owner, detailData in
                if let url = detailData.backdropPath {
                    let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(url)")
                    owner.detailView.posterImageView.kf.setImage(with: imageURL)
                }
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
                cell.configureData(posterPath: element.poster_path)
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
                MediaRepository.shared.addMedia(media: value.1, type: owner.viewModel.type, image: owner.detailView.posterImageView.image) {
                    owner.showAlert(text: "이미 저장된 미디어에요 :)")
                } success: {
                    owner.showAlert(text: "미디어를 저장했어요 :)")
                }
            }
            .disposed(by: disposeBag)
    }
    
    func showAlert(text: String) {
        let alert = AlertViewController()
        alert.alertView.titleLabel.text = text
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: true)
    }
}
