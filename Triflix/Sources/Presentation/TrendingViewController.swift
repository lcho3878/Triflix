//
//  TrendingViewController.swift
//  Triflix
//
//  Created by 이찬호 on 10/8/24.
//

import UIKit
import RxCocoa
import RxSwift

enum SeriesType {
    case movie
    case tv
}

final class TrendingViewController: BaseViewController {
    
    private let trendingView = TrendingView()
    private let viewModel = TrendingViewModel()
    private let disposeBag = DisposeBag()
   
    private let viewDidLoadTrigger = PublishSubject<Void>()
    
    override func loadView() {
        view = trendingView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        bind()
    }
}
// MARK:  뷰컨 구성
extension TrendingViewController{
    private func configureVC() {
        // Navigation Bar 구성        
        let profileBtn = UIButton(type: .custom)
        profileBtn.topProfileUI(imageName: "logo")
              let menuBarItem = UIBarButtonItem(customView: profileBtn)
              let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 40)
              let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 40)
              currWidth?.isActive = true
              currHeight?.isActive = true
              navigationItem.leftBarButtonItem = menuBarItem
        navigationItem.rightBarButtonItems = [trendingView.magnifyingglassItem, trendingView.sparkleItem]
        trendingView.trendingMovieCV.register(PosterImageCell.self, forCellWithReuseIdentifier: PosterImageCell.id)
        trendingView.trendingMovieCV.showsHorizontalScrollIndicator = false
        trendingView.trendingTVCV.register(PosterImageCell.self, forCellWithReuseIdentifier: PosterImageCell.id)
        trendingView.trendingTVCV.showsHorizontalScrollIndicator = false
    }
}

// MARK:  ViewModel Bind
extension TrendingViewController {
    private func bind() {
        let input = TrendingViewModel.Input(
            viewDidLoadTrigger: viewDidLoadTrigger)
        let output = viewModel.transform(input: input)
        
        trendingView.sparkleItem.rx.tap.bind {
            self.tabBarController?.selectedIndex = 2
        }.disposed(by: disposeBag)
        
        trendingView.magnifyingglassItem.rx.tap.bind {
            self.tabBarController?.selectedIndex = 1
        }.disposed(by: disposeBag)
        
        trendingView.playButton.rx.tap.bind {
            print("재생버튼 탭")
        }.disposed(by: disposeBag)
    
        // realm 저장
        Observable.combineLatest(trendingView.favoriteButton.rx.tap, output.movieOutput)
            .bind(with: self) { owner, value in
                guard let media = value.1.first else { return }
                MediaRepository.shared.addMedia(media: media, type: .movie, image: owner.trendingView.mainPosterImageView.image) {
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
        
        
        output.movieOutput.bind(with: self) { owner, list in
            guard let url = list.first?.poster_path else { return }
            guard let genre = list.first?.genres else { return }
            let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(url)")
            owner.trendingView.mainPosterImageView.kf.setImage(with: imageURL)
            owner.trendingView.mainPosterGenreLabel.text = "\(genre)"
        }
        .disposed(by: disposeBag)
        
        output.movieOutput
            .bind(to: trendingView.trendingMovieCV.rx.items(cellIdentifier: PosterImageCell.id, cellType: PosterImageCell.self)) { (row, element, cell) in
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
        
        trendingView.trendingMovieCV.rx.modelSelected(MediaResult.Media.self).bind(with: self) { owner, media in
            owner.presentDetailViewController(media: media, type: .movie, isPresent: true)
        }
        .disposed(by: disposeBag)
        
        output.TVOutput
            .bind(to: trendingView.trendingTVCV.rx.items(cellIdentifier: PosterImageCell.id, cellType: PosterImageCell.self)) { (row, element, cell) in
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
        
        trendingView.trendingTVCV.rx.modelSelected(MediaResult.Media.self).bind(with: self) { owner, media in
            owner.presentDetailViewController(media: media, type: .tv, isPresent: true)
        }
        .disposed(by: disposeBag)
        
        viewDidLoadTrigger.onNext(())
    }
}

