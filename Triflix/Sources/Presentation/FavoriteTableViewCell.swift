//
//  FavoriteTableViewCell.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import UIKit

final class FavoriteTableViewCell: UITableViewCell {
    static var id = "FavoriteTableViewCell"
    
    private let titleLabel = {
        let view = UILabel()
        view.text = "기본"
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteTableViewCell {
    private func addSubviews() {
        contentView.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.center.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configureData(_ data: FavoriteMedia) {
        titleLabel.text = data.title
    }
}
