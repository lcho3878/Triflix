//
//  FavoriteTableViewCell.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import UIKit
import SnapKit

final class FavoriteTableViewCell: UITableViewCell {
    
    private let posterImageView = {
        let view = UIImageView()
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    private let titleLabel = {
        let view = UILabel()
        view.text = "기본"
        return view
    }()
    
    private let playButton = {
        var configuration = UIButton.Configuration.plain()
        let image = UIImage(systemName: "play.circle")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        configuration.image = image?.applyingSymbolConfiguration(.init(pointSize: 40))
        let view = UIButton(configuration: configuration)
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
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
    }
    
    private func setConstraints() {
        posterImageView.snp.makeConstraints {
            $0.leading.equalTo(safeAreaLayoutGuide).offset(8)
            $0.verticalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            $0.width.equalTo(150)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(posterImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(safeAreaLayoutGuide)
        }
        
        playButton.snp.makeConstraints {
            $0.verticalEdges.equalTo(safeAreaLayoutGuide).inset(24)
            $0.width.equalTo(playButton.snp.height)
            $0.centerY.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(8)
        }
    }
    
    func configureData(_ data: FavoriteMedia) {
        titleLabel.text = data.title
    }
}
