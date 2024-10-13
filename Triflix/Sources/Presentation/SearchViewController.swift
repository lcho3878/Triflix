//
//  SearchViewController.swift
//  Triflix
//
//  Created by 이찬호 on 10/8/24.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

final class SearchViewController: BaseViewController {
    // MARK: Properties
    private let searchView = SearchView()
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: View Life Cycle
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        bind()
    }
}

// MARK: configureCollectionView
extension SearchViewController {
    private func configureCollectionView() {
        searchView.collectionView.register(PosterImageCell.self, forCellWithReuseIdentifier: PosterImageCell.id)
        searchView.collectionView.showsVerticalScrollIndicator = false
    }
}

// MARK: bind
extension SearchViewController {
    private func bind() {
        let indexPathInput = PublishSubject<[IndexPath]>()
        
        let input = SearchViewModel.Input(
            searchButtonClicked: searchView.searchBar.rx.searchButtonClicked,
            searchQuery: searchView.searchBar.rx.text.orEmpty,
            indexPathInput: indexPathInput
        )
        let output = viewModel.transform(input: input)
        
        output.searchData
            .bind(to: searchView.collectionView.rx.items(cellIdentifier: PosterImageCell.id, cellType: PosterImageCell.self)) { (row, element, cell) in
                if let imageData = element.poster_path {
                    let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(imageData)")
                    cell.posterImageView.kf.setImage(with: imageURL, options: [.transition(.fade(0.7))])
                    cell.posterImageView.kf.indicatorType = .activity
                } else {
                    cell.posterImageView.image = UIImage(systemName: "movieclapper")
                    cell.posterImageView.tintColor = .white
                    cell.posterImageView.contentMode = .scaleAspectFit
                }
            }
            .disposed(by: disposeBag)
        
        output.presetnView
            .bind(with: self) { owner, value in
                switch value {
                case 1: 
                    owner.searchView.topTitleLabel.rx.text.onNext("추천 영화 & 시리즈")
                    owner.searchView.collectionView.rx.isHidden.onNext(false)
                    owner.searchView.emptyLabel.rx.isHidden.onNext(true)
                    owner.searchView.topTitleLabel.rx.isHidden.onNext(false)
                case 2:
                    owner.searchView.topTitleLabel.rx.text.onNext("영화 & 시리즈")
                    owner.searchView.collectionView.rx.isHidden.onNext(false)
                    owner.searchView.emptyLabel.rx.isHidden.onNext(true)
                    owner.searchView.topTitleLabel.rx.isHidden.onNext(false)
                case 3:
                    owner.searchView.topTitleLabel.rx.text.onNext("영화 & 시리즈")
                    owner.searchView.collectionView.rx.isHidden.onNext(true)
                    owner.searchView.emptyLabel.rx.isHidden.onNext(false)
                    owner.searchView.topTitleLabel.rx.isHidden.onNext(true)
                default: break
                }
            }
            .disposed(by: disposeBag)
        
        searchView.collectionView.rx.prefetchItems
            .bind(with: self) { owner, indexPaths in
                indexPathInput.onNext(indexPaths)
            }
            .disposed(by: disposeBag)
        
        searchView.collectionView.rx.modelSelected(MediaResult.Media.self)
            .bind(with: self) { owner, result in
                owner.presentDetailViewController(media: result, type: .movie, isPresent: true)
            }
            .disposed(by: disposeBag)
    }
}
