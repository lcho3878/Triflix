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

final class SearchViewController: UIViewController {
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
    
    private func configureCollectionView() {
        searchView.collectionView.register(PosterImageCell.self, forCellWithReuseIdentifier: PosterImageCell.id)
        searchView.collectionView.showsVerticalScrollIndicator = false
    }
    
    private func bind() {
        let input = SearchViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.searchData
            .bind(to: searchView.collectionView.rx.items(cellIdentifier: PosterImageCell.id, cellType: PosterImageCell.self)) { (row, element, cell) in
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
    }
}
