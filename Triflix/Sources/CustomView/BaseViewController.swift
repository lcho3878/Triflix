//
//  BaseViewController.swift
//  Triflix
//
//  Created by 이찬호 on 10/9/24.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {}

extension BaseViewController {
    func presentDetailViewController(media: MediaResult.Media, type: Router.DetailType, isPresent: Bool) {
        let detailVC = DetailViewController()
        detailVC.viewModel.id = media.id
        detailVC.viewModel.type = type
        if isPresent {
            let detailNav = UINavigationController(rootViewController: detailVC)
            detailNav.modalPresentationStyle = .fullScreen
            present(detailNav, animated: true)
        }
        else {
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
