//
//  TrendingViewController.swift
//  Triflix
//
//  Created by 이찬호 on 10/8/24.
//

import UIKit
import RxCocoa
import RxSwift

final class TrendingViewController: BaseViewController {
    
    let trendingView = TrendingView()
    let trendingViewModel = TrendingViewModel()
    let disposeBag = DisposeBag()
    
    override func loadView() {
        view = trendingView
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
        navigationItem.rightBarButtonItems = [trendingView.magnifyingglassItem, trendingView.sparkleItem]
    }
}

// MARK:  ViewModel Bind
extension TrendingViewController {
    private func bind() {
        
        trendingView.sparkleItem.rx.tap.bind {
            self.tabBarController?.selectedIndex = 2
        }.disposed(by: disposeBag)
        
        trendingView.magnifyingglassItem.rx.tap.bind {
            self.tabBarController?.selectedIndex = 1
        }.disposed(by: disposeBag)
        
        trendingView.playButton.rx.tap.bind {
            print("재생버튼 탭")
        }.disposed(by: disposeBag)
        
        trendingView.favoriteButton.rx.tap.bind {
            print("찜 버튼 탭")
        }.disposed(by: disposeBag)
        
    }
}
