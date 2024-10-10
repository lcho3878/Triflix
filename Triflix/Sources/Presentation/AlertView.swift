//
//  AlertView.swift
//  Triflix
//
//  Created by YJ on 10/10/24.
//

import UIKit
import SnapKit

final class AlertView: BaseView {
    // MARK: UI
    private let alertBgView = UIView()
    let titleLabel = UILabel()
    let okButton = UIButton()
    
    // MARK: Functions
    override func addSubviews() {
        addSubviews([alertBgView, titleLabel, okButton])
    }
    
    override func setConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        alertBgView.snp.makeConstraints {
            $0.center.equalTo(safeArea.snp.center)
            $0.horizontalEdges.equalTo(safeArea).inset(30)
            $0.height.equalTo(110)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertBgView.snp.top).offset(20)
            $0.horizontalEdges.equalTo(alertBgView.snp.horizontalEdges).inset(20)
        }
        
        okButton.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(alertBgView.snp.horizontalEdges).inset(10)
            $0.bottom.equalTo(alertBgView.snp.bottom).offset(-15)
        }
    }
    
    override func configureUI() {
        backgroundColor = .clear
        
        alertBgView.backgroundColor = .alertBg
        alertBgView.layer.opacity = 0.7
        alertBgView.layer.cornerRadius = 7
        titleLabel.setUI(.white, .center, numOfLines: 1, fontSize: 16, .semibold)
        okButton.setTitle("확인", for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .alertButton
        okButton.layer.cornerRadius = 7
    }
}
