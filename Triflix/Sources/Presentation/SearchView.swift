//
//  SearchView.swift
//  Triflix
//
//  Created by YJ on 10/10/24.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    // MARK: UI
    let searchBar = UISearchBar()
    let topTitleLabel = UILabel()
    
    let emptyLabel = {
        let view = UILabel()
        view.text = "결과값이 없습니다."
        return view
    }()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.layout())
    
    // MARK: Functions
    override func addSubviews() {
        addSubviews([searchBar, topTitleLabel, collectionView, emptyLabel])
    }
    
    override func setConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeArea)
        }
        
        topTitleLabel.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(safeArea).inset(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(topTitleLabel.snp.bottom).offset(5)
            $0.horizontalEdges.equalTo(safeArea)
            $0.bottom.equalTo(safeArea)
        }
        
        emptyLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func configureUI() {
        searchBar.placeholder = "게임, 시리즈, 영화를 검색하세요.."
        topTitleLabel.setUI(fontSize: 16, .bold)
        topTitleLabel.text = "영화 & 시리즈"
    }
}
