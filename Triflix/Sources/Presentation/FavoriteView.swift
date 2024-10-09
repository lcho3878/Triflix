//
//  FavoriteView.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import UIKit
import SnapKit

final class FavoriteView: BaseView {
    
    let tableView = {
        let view = UITableView()
        view.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.id)
        return view
    }()
    
    override func addSubviews() {
        addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


